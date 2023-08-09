module WebPushService
  class << self
    def payload_send(message, subscription, **options)
      WebPushService::Request.new(
        message: message,
        subscription: {
          endpoint: subscription.endpoint,
          keys: {
            p256dh: subscription.p256dh_key,
            auth: subscription.auth_key
          }
        },
        vapid: {
          public_key: ENV['VAPID_PUBLIC_KEY'],
          private_key: ENV['VAPID_PRIVATE_KEY']
        },
        **options
      ).perform
    end

    def encode64(bytes)
      Base64.urlsafe_encode64(bytes)
    end

    def decode64(str)
      Base64.urlsafe_decode64(str)
    end
  end
end
