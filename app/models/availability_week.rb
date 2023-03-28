class AvailabilityWeek < ApplicationRecord
  belongs_to :user

  DAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze

  before_create :set_default_day_values

  private

  def set_default_day_values
    days_of_week = user.days_of_week
    self.week_enabled = true

    self.available_monday = days_of_week.include?("Monday")
    self.available_tuesday = days_of_week.include?("Tuesday")
    self.available_wednesday = days_of_week.include?("Wednesday")
    self.available_thursday = days_of_week.include?("Thursday")
    self.available_friday = days_of_week.include?("Friday")
    self.available_saturday = days_of_week.include?("Saturday")
    self.available_sunday = days_of_week.include?("Sunday")
  end
end
