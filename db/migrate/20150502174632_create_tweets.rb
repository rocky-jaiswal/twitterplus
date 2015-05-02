class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets, id: false do |t|
      t.bigint   :id, null: false
      t.text     :full_text, null: false
      t.bigint   :friend_twitter_id, null: false

      t.references :user, type: "integer"
      t.timestamps null: false
    end
    add_index :tweets, :id, unique: true
  end
end
