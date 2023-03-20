class CreateAvailables < ActiveRecord::Migration[7.0]
  def change
    create_table :availables do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
