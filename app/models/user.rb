class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :confirmable, :lockable, :timeoutable,
         :omniauthable, :omniauth_providers => [:twitter]

  def enrich_oauth_info(auth)
    self.provider      = auth["provider"]
    self.uid           = auth["uid"]
    self.oauth_details = auth["extra"]["access_token"].params
    self.save!
  end

  def twitter_client
    @__twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_key']
      config.consumer_secret     = ENV['twitter_secret']
      config.access_token        = self.oauth_details['oauth_token']
      config.access_token_secret = self.oauth_details['oauth_token_secret']
    end
  end

  def refresh_friends
    twitter_client.friends.each do |friend|
      self.friends.create!(friend.slice(:id, :name, :screen_name,
                                        :url, :description, :followers_count,
                                        :friends_count, :profile_image_url, :following))
    end
  end

end
