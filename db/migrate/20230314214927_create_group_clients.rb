class CreateGroupClients < ActiveRecord::Migration[7.0]
  def change
    create_table :group_clients do |t|
      t.belongs_to :group, null: false, foreign_key: true
      t.belongs_to :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
