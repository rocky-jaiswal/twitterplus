class AddOauthDetailsToUser < ActiveRecord::Migration
  def up
    enable_extension 'hstore'
    add_column :users, :provider, :text
    add_column :users, :uid, :text
    add_column :users, :oauth_details, :hstore, default: {}
  end

  def down
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :oauth_details
  end
end
