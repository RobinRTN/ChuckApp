require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"
require 'active_support/time'

class BookingsController < ApplicationController
  CALENDAR_ID = 'primary'

  def disponibilites
    interval = 30
    slot_duration = 1.hour
    start_time = Time.zone.parse('9:00am')
    end_time = Time.zone.parse('21:00pm') - slot_duration
    days_of_week = ["Monday", "Wednesday", "Thursday", "Friday"]
    num_weeks = 4
    @user_bookings = current_user.bookings.upcoming
    # Generate the available datetimes using the generate_datetimes function
    full_datetimes = generate_datetimes(start_time, end_time, days_of_week, interval, num_weeks, slot_duration)
    @full_datetimes = full_datetimes
  end


  def new
    @booking = Booking.new
  end

  def index
    user_bookings = current_user.bookings
    @today_bookings = user_bookings.today
    @tomorrow_bookings = user_bookings.tomorrow
    @this_week_bookings = user_bookings.this_week
    @next_week_bookings = user_bookings.next_week
    @next_month_bookings = user_bookings.next_month
    @after_bookings = user_bookings.after
    @passed_bookings = user_bookings.passed

    @today_pending_bookings = user_bookings.today_pending
    @tomorrow_pending_bookings = user_bookings.tomorrow_pending
    @this_week_pending_bookings = user_bookings.this_week_pending
    @next_week_pending_bookings = user_bookings.next_week_pending
    @next_month_pending_bookings = user_bookings.next_month_pending
    @after_pending_bookings = user_bookings.after_pending
  end

  def confirm
    @booking = Booking.find(params[:id])
    @booking.update(status: "Accepted")
    redirect_to bookings_path
  end

  def refuse
    @booking = Booking.find(params[:id])
    @booking.update(status: "Refused")
    redirect_to bookings_path
  end

  def create
    client = get_google_calendar_client current_user
    booking = params[:booking]
    event = get_event booking
    client.insert_event('primary', event)
    flash[:notice] = 'booking was successfully added.'
    redirect_to bookings_path
  end

  def get_google_calendar_client current_user
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)
    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => current_user.access_token,
        "refresh_token" => current_user.refresh_token,
        "client_id" => ENV["GOOGLE_API_KEY"],
        "client_secret" => ENV["GOOGLE_API_SECRET"]
      }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if !current_user.present?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      flash[:error] = 'Your token has been expired. Please login again with google.'
      redirect_to :back
    end
    client
  end

  private

  def get_event booking
    # attendees = booking[:members].split(',').map{ |t| {email: t.strip} }
    event = Google::Apis::CalendarV3::Event.new({
      summary: booking[:title],
      location: '800 Howard St., San Francisco, CA 94103',
      description: booking[:description],
      start: {
        date_time: Time.new(booking['start_date(1i)'],booking['start_date(2i)'],booking['start_date(3i)'],booking['start_date(4i)'],booking['start_date(5i)']).to_datetime.rfc3339,
        time_zone: "Asia/Kolkata"
        # date_time: '2019-09-07T09:00:00-07:00',
        # time_zone: 'Asia/Kolkata',
      },
      end: {
        date_time: Time.new(booking['end_date(1i)'],booking['end_date(2i)'],booking['end_date(3i)'],booking['end_date(4i)'],booking['end_date(5i)']).to_datetime.rfc3339,
        time_zone: "Asia/Kolkata"
      },
      # attendees: attendees,
      reminders: {
        use_default: false,
        overrides: [
          Google::Apis::CalendarV3::EventReminder.new(reminder_method:"popup", minutes: 10),
          Google::Apis::CalendarV3::EventReminder.new(reminder_method:"email", minutes: 20)
        ]
      },
      notification_settings: {
        notifications: [
                        {type: 'event_creation', method: 'email'},
                        {type: 'event_change', method: 'email'},
                        {type: 'event_cancellation', method: 'email'},
                        {type: 'event_response', method: 'email'}
                       ]
      }, 'primary': true
    })
  end


  def generate_datetimes(start_time, end_time, given_days_of_week, interval, num_weeks, slot_duration)
    Time.zone = 'Europe/Paris'
    full_datetimes = []
    weekly_datetimes = []
    daily_datetimes = []
    current_time = Time.zone.now

    # Loop through each day of the current week
    (0..num_weeks - 1).each do |week_num|
      given_days_of_week.each do |day|
        target_day = Date.parse(day)
        target_day += (7 * week_num)
        slot = Time.zone.local(target_day.year, target_day.month, target_day.day, start_time.hour, start_time.min, start_time.sec)
        while slot <= Time.zone.local(target_day.year, target_day.month, target_day.day, end_time.hour, end_time.min, end_time.sec)
          if slot.strftime("%H:%M:%S") >= start_time.strftime("%H:%M:%S") && slot.strftime("%H:%M:%S") <= end_time.strftime("%H:%M:%S")
            daily_datetimes << slot unless slot < current_time
          end
          slot += interval.minutes
        end
        sort_existing_bookings(daily_datetimes)
        sort_future_bookings(daily_datetimes, slot_duration)
        weekly_datetimes << daily_datetimes unless daily_datetimes.empty?
        daily_datetimes = []
      end
      full_datetimes << weekly_datetimes
      weekly_datetimes = []
    end
    return full_datetimes
  end

  def sort_existing_bookings(daily_datetimes)
    overlapping_slots = []
    daily_datetimes.each do |slot|
      slot_string = slot.strftime("%Y-%m-%d %H:%M:%S %z")
      @user_bookings.each do |booking|
        booking_start = booking.start_time.strftime("%Y-%m-%d %H:%M:%S %z")
        booking_end = booking.end_time.strftime("%Y-%m-%d %H:%M:%S %z")
        if slot_string >= booking_start && slot_string < booking_end
          overlapping_slots << slot
          break # Exit the inner loop early
        end
      end
    end
    daily_datetimes.reject! { |slot| overlapping_slots.include?(slot) }
  end

  def sort_future_bookings(daily_datetimes, slot_duration)
    overlapping_slots = []
    daily_datetimes.each do |slot|
      slot_added_minimal = slot + slot_duration
      puts slot
      puts slot_added_minimal
      @user_bookings.each do |booking|
        booking_start = booking.start_time.strftime("%Y-%m-%d %H:%M:%S %z")
        booking_end = booking.end_time.strftime("%Y-%m-%d %H:%M:%S %z")
        if slot_added_minimal >= booking_start && slot_added_minimal < booking_end
          overlapping_slots << slot_added_minimal
          puts "found this one #{slot_added_minimal}"
          puts "after the starting booking #{booking_start}"
          puts "before the ending booking #{booking_end}"
          break # Exit the inner loop early
        end
      end
    end
    daily_datetimes.reject! { |slot| overlapping_slots.include?(slot) }
  end
end
