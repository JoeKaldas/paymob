# frozen_string_literal: true

require "faraday"
require "active_support"

require_relative "paymob/version"

# API resource support classes
require "paymob/errors"

# API operations
require "paymob/actions/application_service"
require "paymob/actions/login"
require "paymob/actions/payment_token"
require "paymob/actions/pay_card"
require "paymob/actions/pay_token"

module Paymob
  BASE_URI = "https://accept.paymobsolutions.com/api"

  class << self
    attr_accessor :api_key
  end

  def self.configure
    yield self
  end
end
