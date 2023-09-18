module PaymobRuby
  module Hmac
    class << self
      def calc_secure_hash(data) # rubocop:disable Metrics/AbcSize
        digest = ::OpenSSL::Digest.new("sha512")
        # rubocop:disable Layout/LineLength
        str = "#{data['obj']['amount_cents']}#{data['obj']['created_at']}#{data['obj']['currency']}#{data['obj']['error_occured']}#{data['obj']['has_parent_transaction']}#{data['obj']['id']}#{data['obj']['integration_id']}#{data['obj']['is_3d_secure']}#{data['obj']['is_auth']}#{data['obj']['is_capture']}#{data['obj']['is_refunded']}#{data['obj']['is_standalone_payment']}#{data['obj']['is_voided']}#{data['obj']['order']['id']}#{data['obj']['owner']}#{data['obj']['pending']}#{data['obj']['source_data']['pan']}#{data['obj']['source_data']['sub_type']}#{data['obj']['source_data']['type']}#{data['obj']['success']}"
        # rubocop:enable Layout/LineLength
        ::OpenSSL::HMAC.hexdigest(digest, PaymobRuby.hmac_key, str)
      end
    end
  end
end
