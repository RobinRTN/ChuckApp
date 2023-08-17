class PushNotificationService
  class << self
    def send(user, title, message, url)
      new(user, title, message, url).send
    end
  end

  def initialize(user, title, message, url)
    @user = user
    @subscriptions = user.subscriptions
    @title = title
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
      title: @title,
      body: @message,
      data: {
        url: @url
      }
    }
    WebPushService.payload_send(JSON.generate(notif_data), subscription)
  end
end
