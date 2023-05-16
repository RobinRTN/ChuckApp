class RemoveUserIdFromFormules < ActiveRecord::Migration[7.0]
  def change
    remove_column :formules, :user_id, :bigint
  end
end
