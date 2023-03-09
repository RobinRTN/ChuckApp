module ApplicationHelper
  require 'active_support/time'

  def reservation_link(token)
    if Rails.env.production?
      "https://salty-sierra-39179.herokuapp.com/landing_reservation/#{token}"
    else
      "http://localhost:3000/landing_reservation/#{token}"
    end
  end

  def events_ajax_previous_link
    ->(param, date_range) { link_to raw("&laquo;"), {param => date_range.first - 1.day}, remote: :true}
  end

  def events_ajax_next_link
    ->(param, date_range) { link_to raw("&raquo;"), {param => date_range.last + 1.day}, remote: :true}
  end
  
end
