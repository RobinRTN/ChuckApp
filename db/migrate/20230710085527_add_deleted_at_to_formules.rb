class AddDeletedAtToFormules < ActiveRecord::Migration[7.0]
  def change
    add_column :formules, :deleted_at, :datetime
    add_column :formules, :archived, :boolean, default: false
  end
end
