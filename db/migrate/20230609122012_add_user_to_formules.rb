class AddUserToFormules < ActiveRecord::Migration[7.0]
  def change
    add_reference :formules, :user, foreign_key: true
  end
end
