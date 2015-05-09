class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :confirmable, :lockable, :timeoutable,
         :omniauthable, :omniauth_providers => [:twitter]

  has_many :friends, dependent: :destroy
  has_many :groups,  dependent: :destroy
  has_many :tweets,  dependent: :destroy

  def enrich_oauth_info(auth)
    self.provider      = auth["provider"]
    self.uid           = auth["uid"]
    self.oauth_details = auth["extra"]["access_token"].params
    self.save!
  end

  def twitter_client
    @__twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_key']
      config.consumer_secret     = ENV['twitter_secret']
      config.access_token        = self.oauth_details['oauth_token']
      config.access_token_secret = self.oauth_details['oauth_token_secret']
    end
  end

  def twitter_user
    @__twitter_user ||= twitter_client.user(self.oauth_details["user_id"].to_i)
  end

  def refresh_friends!
    with_error_handling do
      tw_friends = twitter_client.friends({count: 200})
      tw_friends.each do |friend|
        self.friends.find_or_create_by!(screen_name: friend.screen_name) do |f|
          f.name =               friend.name.to_s
          f.screen_name =        friend.screen_name
          f.twitter_id =         friend.id
          f.url =                friend.uri.to_s
          f.website =            friend.website.to_s
          f.profile_image_url =  friend.profile_image_url.to_s
          f.description =        friend.description
          f.followers_count =    friend.followers_count
          f.friends_count =      friend.friends_count
          f.following =          friend.following?
        end
      end
    end
  end

  def refresh_tweets!
    options = { count: 200, trim_user: true, include_rts: true }
    options.merge(since_id: last_fetched_tweet_id) if self.last_fetched_tweet_id
    tweets = twitter_client.home_timeline(options)
    save_tweets! tweets
  end

  def save_tweets!(tweets)
    with_error_handling do
      tweets.each do |tweet|
        self.tweets.find_or_create_by!(id: tweet.id) do |t|
          t.full_text         = tweet.full_text
          t.friend_twitter_id = tweet.user.id
        end
      end
      update_last_fetched_tweet_id!
    end
  end

  def update_last_fetched_tweet_id!
    last_fetched_tweet_id = self.tweets.sort_by{|t| t.id}.last
    self.update!(last_fetched_tweet_id: last_fetched_tweet_id)
  end

  def unassigned_friends
    self.friends.unassigned
  end

  def organized_tweets
    refresh_tweets if self.tweets.blank?
    self.tweets.order(id: :desc).each_with_object({}) do |tweet, organized_tweets|
      tweeted_by = tweet.tweeted_by
      organized_tweets[tweeted_by.group.name] = [] if organized_tweets[tweeted_by.group.name].nil?
      organized_tweets[tweeted_by.group.name] << tweet.as_json
    end
  end

  def organized_friends
    self.groups.each_with_object({}) do |group, hash|
      hash[group.name] = group.friends.map(&:as_json)
    end
  end

  private

  def with_error_handling(&block)
    block.call
  rescue => e
    #TODO Handle the rate limit exception
    Rails.logger.error e.class
    Rails.logger.error e.message
    Rails.logger.error e.inspect
    Rails.logger.error e.backtrace.join("\n")
    raise e
  end

end
