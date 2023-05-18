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

  def duration_options
    ['15min', '30min', '45min', '1h', '2h', '2h30', '3h', '4h', '5h', '6h', '10h', '12h']
  end

  def time_selection
    (4..23).flat_map { |h| ["%02d:00" % h, "%02d:30" % h] } + ["00:00"]
  end

  def generate_time_slots(start_time, end_time)
    start_time = Time.parse(start_time) if start_time.is_a?(String)
    end_time = Time.parse(end_time) if end_time.is_a?(String)

    time_slots = []
    while start_time < end_time
      time_slots << start_time
      start_time += 30.minutes
    end

    time_slots.pop if time_slots.last == end_time
    time_slots
  end


  def english_to_french_day(day)
    day_mapping = {
      "Monday" => "Lun.",
      "Tuesday" => "Mar.",
      "Wednesday" => "Mer.",
      "Thursday" => "Jeu.",
      "Friday" => "Ven.",
      "Saturday" => "Sam.",
      "Sunday" => "Dim."
    }

    day_mapping[day]
  end


end
