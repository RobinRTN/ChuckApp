module WebPushService
  class VapidKey
    def self.from_keys(public_key, private_key)
      key = new
      key.set_keys! public_key, private_key
      key
    end

    attr_reader :curve

    def initialize(pkey = nil)
      @curve = pkey
      @curve = OpenSSL::PKey::EC.generate('prime256v1') if @curve.nil?
    end

    def set_keys!(public_key = nil, private_key = nil)
      if public_key.nil?
        public_key = curve.public_key
      else
        public_key = OpenSSL::PKey::EC::Point.new(group, to_big_num(public_key))
      end

      if private_key.nil?
        private_key = curve.private_key
      else
        private_key = to_big_num(private_key)
      end

      asn1 = OpenSSL::ASN1::Sequence([
        OpenSSL::ASN1::Integer.new(1),
        OpenSSL::ASN1::OctetString(private_key.to_s(2)),
        OpenSSL::ASN1::ObjectId('prime256v1', 0, :EXPLICIT),
        OpenSSL::ASN1::BitString(public_key.to_octet_string(:uncompressed), 1, :EXPLICIT),
      ])

      der = asn1.to_der

      @curve = OpenSSL::PKey::EC.new(der)
    end

    def group
      curve.group
    end

    def public_key_for_push_header
      trim_encode64(curve.public_key.to_bn.to_s(2))
    end

    private

    def to_big_num(key)
      OpenSSL::BN.new(WebPush.decode64(key), 2)
    end

    def encode64(bin)
      WebPushService.encode64(bin)
    end

    def trim_encode64(bin)
      encode64(bin).delete('=')
    end
  end
end
