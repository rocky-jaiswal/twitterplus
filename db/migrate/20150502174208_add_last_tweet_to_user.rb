class AddLastTweetToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_fetched_tweet_id, :bigint
  end
end
