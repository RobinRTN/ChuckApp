module ApplicationHelper
  require 'active_support/time'

  def reservation_link(token)
    if Rails.env.production?
      "http://chuckapp.fr/#{token}"
    else
      "http://localhost:3000/#{token}"
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
    [
      ['15min', 15],
      ['30min', 30],
      ['45min', 45],
      ['1h', 60],
      ['1h30', 90],
      ['2h', 120],
      ['2h30', 150],
      ['3h', 180],
      ['4h', 240],
      ['5h', 300],
      ['6h', 360],
      ['10h', 600],
      ['12h', 720]
    ]
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

  def link_to_add_row(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |formule_fields|
      render(association.to_s.singularize, f: formule_fields)
    end
    link_to(name, '#', class: "add_fields" + args[:class], data: { id: id, fields: fields.gsub("\n", ""),  action: "click->add-formule-package#addFields" })
  end

  def meta_image
    image_path("Meta-Full-Logo.png")
  end

  def any_future_slots?(weekly_datetimes)
    weekly_datetimes.any? do |daily_datetimes|
      daily_datetimes.any? { |datetime| datetime > Time.zone.now }
    end
  end

end
