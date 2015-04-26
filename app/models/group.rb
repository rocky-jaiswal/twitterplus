class Group < ActiveRecord::Base
  belongs_to :user
  has_many   :friends

  validates :name, presence: true
end
