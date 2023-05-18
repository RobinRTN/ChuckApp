class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_pending_booking

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def set_pending_booking
    @pending_booking = current_user.bookings.all_pending.first if current_user
  end
end
