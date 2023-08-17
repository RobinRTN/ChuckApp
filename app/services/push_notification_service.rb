class PushNotificationService
  class << self
    def send(user, message, url)
      new(user, message, url).send
    end
  end

  def initialize(user, message, url)
    @user = user
    @subscriptions = user.subscriptions
    @message = message
    @url = url
  end

  def send
    @subscriptions.each do |subscription|
      send_push_notification(subscription)
    end
  end

  private

  def send_push_notification(subscription)
    notif_data = {
      title: "Nouvelle demande de réservation",
      body: @message,
      data: {
        url: @url
      }
    }
    WebPushService.payload_send(JSON.generate(notif_data), subscription)
end
end
