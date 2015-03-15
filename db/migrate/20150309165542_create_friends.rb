class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.text    :name
      t.text    :screen_name
      t.text    :url
      t.text    :website
      t.text    :description
      t.integer :followers_count
      t.integer :friends_count
      t.text    :profile_image_url
      t.boolean :following

      t.references :user, type: "integer"
      t.timestamps null: false
    end
  end
end
