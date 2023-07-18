class AddSocialMediaToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :twitter_username, :string
    add_column :users, :instagram_username, :string
    add_column :users, :tiktok_username, :string
  end
end
