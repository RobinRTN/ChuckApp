class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :client, optional: true
  belongs_to :formule, optional: true
  before_create :generate_cancellation_token
  validate :start_time_before_end_time, on: :update



  after_create :send_email_announce, if: :client_type?

  def client_type?
    cancel_type == 'Client'
  end

  def send_email_announce
    BookingMailer.send_email_announce(self).deliver_now if Rails.env.production?
  end

  def start_time_before_end_time
    if start_time >= end_time
      errors.add(:start_time, "Heure de début doit être avant l'heure de fin")
    end
  end

  # scope to print out incoming accepted bookings
  scope :today, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'  AND cancel_type != 'Cancelled'", Time.now, Date.today.end_of_day).order(:start_time) }
  scope :tomorrow, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'  AND cancel_type != 'Cancelled'", Date.tomorrow.beginning_of_day, Date.tomorrow.end_of_day).order(:start_time) }
  scope :this_week, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'  AND cancel_type != 'Cancelled'", Date.tomorrow.end_of_day, Date.today.end_of_week).order(:start_time) }
  scope :next_week, -> { where("start_time > ? AND start_time < ? AND status = 'Accepted'  AND cancel_type != 'Cancelled'", Date.today.end_of_week, Date.today.end_of_week + 7.days).order(:start_time) }
  scope :next_bookings, -> { where("start_time >= ? AND status = 'Accepted'  AND cancel_type != 'Cancelled'", Date.today.end_of_week + 7.days).order(:start_time) }
  scope :next_month, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted'  AND cancel_type != 'Cancelled'", Date.today.end_of_month, Date.today.end_of_month + 1.month).order(:start_time) }
  scope :after, -> { where("start_time >= ?  AND cancel_type != 'Cancelled'", Date.today.end_of_month + 1.month).order(:start_time) }
  scope :passed, -> { where("start_time < ?  AND cancel_type != 'Cancelled'", Time.now).order(:start_time) }
  scope :passed_confirmed, -> { where("start_time < ? AND status = 'Accepted'  AND cancel_type != 'Cancelled'", Time.now).order(:start_time) }
  scope :upcoming, -> { where("start_time >= ? AND cancel_type != 'Cancelled'  AND cancel_type != 'Cancelled'", Time.now).order(:start_time) }
  scope :upcoming_all, -> { where("start_time >= ?", Time.now).order(:start_time) }

  # scope to print out incoming pending bookings
  scope :today_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'  AND cancel_type != 'Cancelled'", Time.now, Date.today.end_of_day).order(:start_time) }
  scope :tomorrow_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'  AND cancel_type != 'Cancelled'", Date.tomorrow.beginning_of_day, Date.tomorrow.end_of_day).order(:start_time) }
  scope :this_week_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'  AND cancel_type != 'Cancelled'", Date.tomorrow.end_of_day, Date.today.end_of_week).order(:start_time) }
  scope :next_week_pending, -> { where("start_time > ? AND start_time < ? AND status = 'Pending'  AND cancel_type != 'Cancelled'", Date.today.end_of_week, Date.today.end_of_week + 7.days).order(:start_time) }
  scope :next_month_pending, -> { where("start_time >= ? AND start_time < ? AND status = 'Pending'  AND cancel_type != 'Cancelled'", Date.today.end_of_month, Date.today.end_of_month + 1.month).order(:start_time) }
  scope :after_pending, -> { where("start_time >= ? AND status = 'Pending' AND cancel_type != 'Cancelled'", Date.today.end_of_week + 7.days).order(:start_time) }
  scope :all_pending, -> { where("start_time >= ? AND status = 'Pending' AND cancel_type != 'Cancelled'", Time.now)}

  # for dashboard
  scope :passed_current_month, -> { where("start_time < ? AND start_time >= ? AND status = 'Accepted' AND cancel_type != 'Cancelled'", Time.now, Time.now.beginning_of_month).order(:start_time) }
  scope :current_month_projected, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted' AND cancel_type != 'Cancelled'", Date.today.beginning_of_month, Date.today.next_month.beginning_of_month).order(:start_time) }
  scope :current_month_rest, -> { where("start_time >= ? AND start_time < ? AND status = 'Accepted' AND cancel_type != 'Cancelled'", Time.now, Date.today.next_month.beginning_of_month).order(:start_time) }

  def duration_in_minutes
    ((end_time - start_time) / 60).round
  end

  private

  def generate_cancellation_token
    self.cancellation_token = SecureRandom.uuid
  end


end
