json.array!(@calendar_bookings) do |event|
  json.extract! event, :id, :name, :start_time
  json.url event_url(event, format: :json)
end
