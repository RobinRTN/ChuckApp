class PushNotificationJob < ApplicationJob
  queue_as :default

  def perform(user, title, message, url)
    PushNotificationService.send(user, title, message, url)
  end
end
