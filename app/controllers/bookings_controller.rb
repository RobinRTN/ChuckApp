class BookingsController < ApplicationController

  def index
    user_bookings = current_user.bookings
    @today_bookings = user_bookings.today
    @tomorrow_bookings = user_bookings.tomorrow
    @this_week_bookings = user_bookings.this_week
    @next_week_bookings = user_bookings.next_week
    @next_month_bookings = user_bookings.next_month
    @after_bookings = user_bookings.after
    @passed_bookings = user_bookings.passed
  end

end
