class AddNoteToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :note, :string
  end
end
