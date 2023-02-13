class CreateFormules < ActiveRecord::Migration[7.0]
  def change
    create_table :formules do |t|
      t.string :name
      t.string :description
      t.string :field
      t.integer :duration
      t.float :price
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
