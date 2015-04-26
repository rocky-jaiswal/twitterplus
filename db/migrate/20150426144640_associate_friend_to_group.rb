class AssociateFriendToGroup < ActiveRecord::Migration
  def change
    add_column :friends, :group_id, :integer
  end
end
