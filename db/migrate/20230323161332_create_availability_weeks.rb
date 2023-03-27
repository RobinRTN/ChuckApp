class CreateAvailabilityWeeks < ActiveRecord::Migration[7.0]
  def change
    create_table :availability_weeks do |t|
      t.references :user, null: false, foreign_key: true
      t.date :week_start
      t.date :week_end
      t.boolean :week_enabled, default: true
      t.boolean :available_monday, default: true
      t.boolean :available_tuesday, default: true
      t.boolean :available_wednesday, default: true
      t.boolean :available_thursday, default: true
      t.boolean :available_friday, default: true
      t.boolean :available_saturday, default: true
      t.boolean :available_sunday, default: true

      t.timestamps
    end
  end
end
