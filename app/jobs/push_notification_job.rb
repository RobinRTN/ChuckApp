class PushNotificationJob < ApplicationJob
  queue_as :default

  def perform(user, message, url)
    PushNotificationService.send(user, message, url)
  end
end
