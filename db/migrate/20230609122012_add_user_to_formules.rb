class AddUserToFormules < ActiveRecord::Migration[7.0]
  def change
    remove_column :formules, :package_id
  end
end
