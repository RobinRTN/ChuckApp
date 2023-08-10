module WebPushService
  class Request
    def initialize(message: '', subscription:, vapid:, **options)
      endpoint = subscription.fetch(:endpoint)
      @endpoint = endpoint
      @uri = URI.parse(@endpoint)
      @payload = build_payload(message, subscription)
      @vapid_options = vapid
      @options = default_options.merge(options)
    end

    def perform
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      http.ssl_timeout  = @options[:ssl_timeout]  unless @options[:ssl_timeout].nil?
      http.open_timeout = @options[:open_timeout] unless @options[:open_timeout].nil?
      http.read_timeout = @options[:read_timeout] unless @options[:read_timeout].nil?

      req = Net::HTTP::Post.new(@uri.request_uri, headers)
      req.body = @payload

      http.request(req)
    end

    def headers
      headers = {}
      headers['Content-Type'] = 'application/octet-stream'
      headers['Ttl']          = @options.fetch(:ttl).to_s
      headers['Urgency']      = @options.fetch(:urgency).to_s

      if @payload
        headers['Content-Encoding'] = 'aes128gcm'
        headers["Content-Length"] = @payload.length.to_s
      end

      headers["Authorization"] = build_vapid_header
      headers
    end

    def build_vapid_header
      vapid_key = VapidKey.from_keys(vapid_public_key, vapid_private_key)
      jwt = JWT.encode(jwt_payload, vapid_key.curve, 'ES256', jwt_header_fields)
      p256ecdsa = vapid_key.public_key_for_push_header
      "vapid t=#{jwt},k=#{p256ecdsa}"
    end

    private

    def jwt_payload
      {
        aud: audience,
        exp: Time.now.to_i + expiration,
        sub: subject
      }
    end

    def jwt_header_fields
      { "typ": "JWT", "alg": "ES256" }
    end

    def audience
      @uri.scheme + '://' + @uri.host
    end

    def expiration
      @vapid_options.fetch(:expiration, 12 * 60 * 60)
    end

    def subject
      @vapid_options.fetch(:subject, 'mailto:sender@example.com')
    end

    def vapid_public_key
      @vapid_options.fetch(:public_key, nil)
    end

    def vapid_private_key
      @vapid_options.fetch(:private_key, nil)
    end

    def build_payload(message, subscription)
      return nil if message.nil? || message.empty?

      encrypt_payload(message, **subscription.fetch(:keys))
    end

    def encrypt_payload(message, p256dh:, auth:)
      Encryption.encrypt(message, p256dh, auth)
    end

    def default_options
      {
        ttl: 60 * 60 * 24 * 7 * 4, # 4 weeks
        urgency: 'normal'
      }
    end
  end
end
