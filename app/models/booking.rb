class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :user
  scope :today, -> { where("start_time >= ? AND start_time < ?", Date.today.beginning_of_day, Date.today.end_of_day).order(:start_time) }
  scope :tomorrow, -> { where("start_time >= ? AND start_time < ?", Date.tomorrow.beginning_of_day, Date.tomorrow.end_of_day).order(:start_time) }
  scope :this_week, -> { where("start_time >= ? AND start_time < ?", Date.tomorrow.end_of_day, Date.today.end_of_week).order(:start_time) }
  scope :next_week, -> { where("start_time >= ? AND start_time < ?", Date.today.end_of_week, Date.today.end_of_week + 7.days).order(:start_time) }
  scope :next_month, -> { where("start_time >= ? AND start_time < ?", Date.today.end_of_month, Date.today.end_of_month + 1.month).order(:start_time) }
  scope :after, -> { where("start_time >= ?", Date.today.end_of_month + 1.month).order(:start_time) }
  scope :passed, -> { where("start_time < ?", Date.today.beginning_of_day).order(:start_time) }
end
