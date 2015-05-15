class Group < ActiveRecord::Base
  belongs_to :user
  has_many   :friends, dependent: :nullify

  validates :name, presence: true

  def as_json(options={})
    {
      id:      self.id,
      name:    self.name,
      friends: self.friends.as_json
    }
  end
end
