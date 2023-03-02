class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:choose_reservation, :landing_reservation, :finish_reservation_missing, :finish_reservation_exist]
end
