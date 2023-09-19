module PaymobRuby
  module Hmac
    FILTERED_TRANSACTION_KEYS = %w[amount_cents created_at currency error_occured has_parent_transaction id
                                   integration_id is_3d_secure is_auth is_capture is_refunded is_standalone_payment
                                   is_voided order.id owner pending
                                   source_data.pansource_data.sub_type source_data.type success].freeze

    class << self
      def valid_signature?(paymob_response)
        digest = ::OpenSSL::Digest.new("sha512")

        concatenated_str = FILTERED_TRANSACTION_KEYS.map do |element|
          paymob_response.dig("obj", *element.split("."))
        end.join
        secure_hash = ::OpenSSL::HMAC.hexdigest(digest, PaymobRuby.hmac_key, concatenated_str)
        secure_hash == paymob_response["hmac"]
      end
    end
  end
end
