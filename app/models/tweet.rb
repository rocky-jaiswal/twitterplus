class Tweet < ActiveRecord::Base
  self.primary_key = :id

  belongs_to :user

  validates :full_text, presence: true
  validates :friend_twitter_id, presence: true

  def as_json(options={})
    {
      id:         self.id,
      full_text:  self.full_text,
      tweeted_by: self.tweeted_by.as_json
    }
  end

  def tweeted_by
    @__tweeted_by ||= Friend.find_by twitter_id: self.friend_twitter_id
  end

end
