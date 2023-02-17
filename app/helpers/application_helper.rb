module ApplicationHelper
  require 'active_support/time'

  def generate_datetimes(start_time, end_time, days_of_week, interval, num_weeks)
    datetimes = []
    current_time = Time.zone.now
    current_day = current_time.strftime("%A")
    current_hour = current_time.hour
    current_min = current_time.min
    current_sec = current_time.sec

    # Loop through each day of the current week
    (0..6).each do |i|
      day = Date.today + i

      # If the current day is a target day, generate datetimes for this day
      if days_of_week.include?(day.strftime("%A"))
        # Calculate the initial datetime for this day
        datetime = Time.zone.local(day.year, day.month, day.day, current_hour, current_min, current_sec)

        # Generate datetimes at the specified interval for this day
        while datetime < end_time && datetime.wday == day.wday
          datetimes << datetime
          datetime += interval.minutes
        end
      end
    end

    # Loop through each week starting from the next week after the current week
    (1..num_weeks).each do |week_num|
      # Loop through each day of the week
      days_of_week.each do |day|
        # Calculate the target day of the week
        target_day = Date.parse(day)
        target_day += (7 * week_num)

        # Calculate the initial datetime for this day
        datetime = Time.zone.local(target_day.year, target_day.month, target_day.day, current_hour, current_min, current_sec)

        # Generate datetimes at the specified interval for this day
        while datetime < end_time && datetime.wday == target_day.wday
          datetimes << datetime
          datetime += interval.minutes
        end
      end
    end

    return datetimes
  end
end
