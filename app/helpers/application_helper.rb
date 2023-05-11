module ApplicationHelper
  require 'active_support/time'

  def reservation_link(token)
    if Rails.env.production?
      "http://chuckapp.fr/landing_reservation/#{token}"
    else
      "http://localhost:3000/landing_reservation/#{token}"
    end
  end

  def filtered_hours(daily_datetimes, user_bookings)
    (4..22).select do |hour|
      datetime = daily_datetimes.first.beginning_of_day + hour.hours
      hour_available?(hour, daily_datetimes.first, user_bookings, daily_datetimes) && datetime > Time.zone.now
    end
  end


  def hour_available?(hour, date, user_bookings, daily_datetimes)
    date_with_hour = date.beginning_of_day + hour.hours
    !daily_datetimes.map(&:hour).include?(hour) && slot_available?(date_with_hour, user_bookings)
  end

  def slot_available?(datetime, user_bookings)
    user_bookings.each do |booking|
      booking_start = booking.start_time
      booking_end = booking.end_time

      if (datetime >= booking_start && datetime < booking_end) ||
         (datetime < booking_start && (datetime + booking.duration_in_minutes.minutes) > booking_start)
        return false
      end
    end
    true
  end

end
