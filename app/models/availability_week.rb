class AvailabilityWeek < ApplicationRecord
  belongs_to :user

  DAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze
end
