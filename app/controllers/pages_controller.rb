class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
    @user_bookings_calendar
    @user_bookings_passed = current_user.bookings.passed_confirmed
    @user_bookings_projected = current_user.bookings.current_month_projected
    @user_bookings_rest = current_user.bookings.current_month_rest
    @user_bookings_number = @user_bookings_passed.count
    @user_bookings_number_proj = @user_bookings_projected.count - @user_bookings_passed.count
    @passed_month_revenues = @user_bookings_passed.sum(&:price)
    @projected_month_revenues = @user_bookings_projected.sum(&:price)
    @client_rankings = rank_clients_by_revenue()
    @upcoming_bookings = current_user.bookings.upcoming

    @calendar_bookings = current_user.bookings.where("start_time BETWEEN ? AND ? AND status = 'Accepted' AND cancel_type != 'Cancelled'", 2.months.ago, 2.months.from_now)
    end
  end

  def profile
  end

  private

  def rank_clients_by_revenue
    current_month_bookings = current_user.bookings.passed_current_month.includes(:client)
    user_revenues = Hash.new(0)
    current_month_bookings.each do |booking|
      user_revenues[booking.client] += booking.price
    end
    sorted_user_revenues = user_revenues.sort_by { |user, revenue| revenue }.reverse
  end

end
