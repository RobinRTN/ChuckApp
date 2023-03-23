class CreateAvailabilityWeeks < ActiveRecord::Migration[7.0]
  def change
    create_table :availability_weeks do |t|
      t.references :user, null: false, foreign_key: true
      t.date :week_start
      t.date :week_end
      t.boolean :week_enabled
      t.boolean :available_monday
      t.boolean :available_tuesday
      t.boolean :available_wednesday
      t.boolean :available_thursday
      t.boolean :available_friday
      t.boolean :available_saturday
      t.boolean :available_sunday

      t.timestamps
    end
  end
end
