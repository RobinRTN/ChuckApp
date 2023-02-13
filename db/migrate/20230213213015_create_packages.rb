class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :description
      t.string :field
      t.integer :number_sessions
      t.float :discount
      t.references :user, null: false, foreign_key: true
      t.references :booking
      t.timestamps
    end
  end
end
