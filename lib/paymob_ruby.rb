# frozen_string_literal: true

require "faraday"
require "active_support"

require_relative "paymob_ruby/version"

# API resource support classes
require "paymob_ruby/errors"

# API operations
require "paymob_ruby/actions/application_service"
require "paymob_ruby/actions/login"
require "paymob_ruby/actions/payment_token"
require "paymob_ruby/actions/pay_card"
require "paymob_ruby/actions/pay_token"

module PaymobRuby
  BASE_URI = "https://accept.paymobsolutions.com/api"

  class << self
    attr_accessor :api_key
  end

  def self.configure
    yield self
  end
end
