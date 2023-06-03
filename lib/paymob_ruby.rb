# frozen_string_literal: true

require_relative "paymob_ruby/version"

# API resource support classes
require "paymob_ruby/errors"
require "paymob_ruby/payment_token"

# API operations
require "paymob_ruby/resources/login"
require "paymob_ruby/resources/pay_card"
require "paymob_ruby/resources/pay_token"

module PaymobRuby
  BASE_URI = "https://accept.paymobsolutions.com/api"

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key

    def initialize
      @api_key = "api_key"
    end
  end
end
