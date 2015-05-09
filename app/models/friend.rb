class Friend < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user, presence: true

  scope :unassigned, -> { where(group: nil) }


  def as_json(options={})
    {
      id: self.id,
      name: self.name,
      screen_name: self.screen_name,
      url: self.url,
      description: self.description,
      friends_count: self.friends_count,
      followers_count: self.followers_count,
      following: self.following,
      profile_image_url: self.profile_image_url
    }
  end

end
