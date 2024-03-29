require "active_support"
require "faraday"
require "json-schema"

require_relative "paymob_ruby/version"

# API resource support classes
require "paymob_ruby/errors"
require "paymob_ruby/configuration"
require "paymob_ruby/hmac"

# API operations
require "paymob_ruby/api/application_service"
require "paymob_ruby/api/login"
require "paymob_ruby/api/payment_token"
require "paymob_ruby/api/pay_card"
require "paymob_ruby/api/pay_token"

require "paymob_ruby/json_schemas/user"

module PaymobRuby
  BASE_URI = "https://accept.paymobsolutions.com/api".freeze

  class << self
    attr_accessor :api_key, :hmac_key

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
