class Group < ActiveRecord::Base
  belongs_to :user
  has_many   :friends

  validates :name, presence: true

  def as_json(options={})
    {
      id:   self.id,
      name: self.name
    }
  end
end
