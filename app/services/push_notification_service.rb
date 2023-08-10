class PushNotificationService
  class << self
    def send(user, message)
      new(user, message).send
    end
  end

  def initialize(user, message)
    @user = user
    @subscriptions = user.subscriptions
    @message = message
  end

  def send
    @subscriptions.each do |subscription|
      send_push_notification(subscription)
    end
  end

  private

  def send_push_notification(subscription)
    notif_data = {
      title: "PushNotificationService title: Pouet pouet 🎺",
      body: "PushNotificationService message: #{@message}",
    }
    WebPushService.payload_send(JSON.generate(notif_data), subscription)
  end
end
