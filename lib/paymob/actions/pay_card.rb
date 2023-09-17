module Paymob
  class PayCard < ApplicationService
    def call(user:, amount:, integration_id:, iframe_id:)
      @iframe_id = iframe_id
      result = Paymob::PaymentToken.call(
        integration_id:,
        user:,
        amount:
      ).payload
      @payment_token = result[:payment_token]

      valid_url?

      success({ payment_link: }.merge(result))
    end

    private

    def valid_url?
      response = ::Faraday.get(payment_link)
      raise InvalidRequestError.new("Invalid iframe ID", :iframe_id, http_status: response.status, http_body: response.body) unless response.success?
    end

    def payment_link
      @payment_link ||= "#{BASE_URI}/acceptance/iframes/#{@iframe_id}?payment_token=#{@payment_token}"
    end
  end
end
