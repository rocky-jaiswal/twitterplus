class Friend < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user, presence: true

  scope :unassigned, -> { where(group: nil) }

end
