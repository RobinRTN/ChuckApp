module ApplicationHelper
  require 'active_support/time'

  def reservation_link(token)
    if Rails.env.production?
      "https://salty-sierra-39179.herokuapp.com/reservation/#{token}"
    else
      "http://localhost:3000/reservation/#{token}"
    end
  end
end
