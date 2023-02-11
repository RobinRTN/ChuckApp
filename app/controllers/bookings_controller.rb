class BookingsController < ApplicationController

  def index
    user_bookings = current_user.bookings
    @upcoming_bookings = user_bookings.select { |booking| booking.start_time > Date.today }
    @past_bookings = user_bookings.select { |booking| booking.start_time < Date.today }
  end

end
