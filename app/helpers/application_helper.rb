module ApplicationHelper
  require 'active_support/time'

  def reservation_link(token)
    if Rails.env.production?
      "https://salty-sierra-39179.herokuapp.com/landing_reservation/#{token}"
    else
      "http://localhost:3000/landing_reservation/#{token}"
    end
  end

  def slot_available?(slot, slot_duration, user_bookings)
    slot_end = slot + slot_duration.minutes
    user_bookings.each do |booking|
      if (slot >= booking.start_time && slot < booking.end_time) ||
         (slot_end > booking.start_time && slot_end <= booking.end_time)
        return false
      end
    end
    true
  end

end
