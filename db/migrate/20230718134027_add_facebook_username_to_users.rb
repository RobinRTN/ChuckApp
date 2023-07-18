class AddFacebookUsernameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :facebook_username, :string
  end
end
