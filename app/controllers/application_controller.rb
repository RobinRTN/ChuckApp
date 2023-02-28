class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:choose_reservation, :finish_reservation, :landing_reservation]
end
