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
    self.friends.delete_all
    tw_friends = twitter_client.friends({count: 200})
    tw_friends.each do |friend|
      self.friends.create!(name: friend.name,
                           screen_name: friend.screen_name,
                           twitter_id: friend.id,
                           url: friend.uri.to_s,
                           website: friend.website.to_s,
                           profile_image_url: friend.profile_image_url.to_s,
                           description: friend.description,
                           followers_count: friend.followers_count,
                           friends_count: friend.friends_count,
                           following: friend.following?)
    end
  rescue => e
    #TODO Handle the rate limit exception
    Rails.logger.error e.class
    Rails.logger.error e.message
    Rails.logger.error e.inspect
    Rails.logger.error e.backtrace.join("\n")
    raise e
  end

  def fetch_tweets
    options = { count: 200, trim_user: true, include_rts: true }
    options.merge(since_id: last_fetched_tweet_id) if last_fetched_tweet_id
    tweets = twitter_client.home_timeline(options)
    save_tweets tweets
  end

  def save_tweets(tweets)
    tweets.each do |tweet|
      self.tweets.create!(id: tweet.id, full_text: tweet.full_text, friend_twitter_id: tweet.user.id)
    end
    self.update!(last_fetched_tweet_id: tweets.first.id)
  rescue => e
    #TODO Handle the rate limit exception
    Rails.logger.error e.class
    Rails.logger.error e.message
    Rails.logger.error e.inspect
    Rails.logger.error e.backtrace.join("\n")
    raise e
  end

  def unassigned_friends
    self.friends.unassigned
  end

end
