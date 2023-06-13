class ChangeNoteInClients < ActiveRecord::Migration[7.0]
  def change
    change_column :clients, :note, :text
  end
end
