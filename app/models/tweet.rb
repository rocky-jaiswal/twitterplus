class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :full_text, presence: true
  validates :friend_twitter_id, presence: true
end
