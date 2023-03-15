class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_pending_booking

  private

  def set_pending_booking
    @pending_booking = Booking.after_pending.first
  end
end
