# frozen_string_literal: true

require "faraday"

require_relative "paymob/version"

# API resource support classes
require "paymob/errors"
require "paymob/payment_token"

# API operations
require "paymob/actions/action"
require "paymob/actions/login"
require "paymob/actions/pay_card"
require "paymob/actions/pay_token"

module Paymob
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
      @api_key = "your_api_key"
    end
  end
end
