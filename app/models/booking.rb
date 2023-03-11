class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :formule
  # scope to print out incoming accepted bookings
  scope :today, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'", Date.today.beginning_of_day, Date.today.end_of_day).order(:start_time) }
  scope :tomorrow, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'", Date.tomorrow.beginning_of_day, Date.tomorrow.end_of_day).order(:start_time) }
  scope :this_week, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'", Date.tomorrow.end_of_day, Date.today.end_of_week).order(:start_time) }
  scope :next_week, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'", Date.today.end_of_week, Date.today.end_of_week + 7.days).order(:start_time) }
  scope :next_bookings, -> { where("start_time >= ? AND status = 'Accepted'", Date.today.end_of_week + 7.days).order(:start_time) }
  scope :next_month, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'", Date.today.end_of_month, Date.today.end_of_month + 1.month).order(:start_time) }
  scope :after, -> { where("start_time >= ?", Date.today.end_of_month + 1.month).order(:start_time) }
  scope :passed, -> { where("start_time < ?", Date.today.beginning_of_day).order(:start_time) }
  scope :upcoming, -> { where("start_time >= ?", Date.today.beginning_of_day).order(:start_time) }

  # scope to print out incoming pending bookings
  scope :today_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'", Date.today.beginning_of_day, Date.today.end_of_day).order(:start_time) }
  scope :tomorrow_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'", Date.tomorrow.beginning_of_day, Date.tomorrow.end_of_day).order(:start_time) }
  scope :this_week_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'", Date.tomorrow.end_of_day, Date.today.end_of_week).order(:start_time) }
  scope :next_week_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'", Date.today.end_of_week, Date.today.end_of_week + 7.days).order(:start_time) }
  scope :next_month_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'", Date.today.end_of_month, Date.today.end_of_month + 1.month).order(:start_time) }
  scope :after_pending, -> { where("start_time >= ?", Date.today.end_of_month + 1.month).order(:start_time) }

  # for dashboard
  scope :passed_current_month, -> { where("start_time < ? AND start_time >= ?", Time.now, Time.now.beginning_of_month).order(:start_time) }
  scope :current_month_projected, -> { where("start_time >= ? AND start_time < ?", Date.today.beginning_of_month, Date.today.next_month.beginning_of_month).order(:start_time) }
  scope :current_month_rest, -> { where("start_time >= ? AND start_time < ?", Time.now, Date.today.next_month.beginning_of_month).order(:start_time) }
end
