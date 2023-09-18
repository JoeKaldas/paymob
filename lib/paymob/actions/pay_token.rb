module Paymob
  class PayToken < ApplicationService
    def call(user:, amount:, integration_id:, cc_token:, commission_fees: 0)
      @cc_token = cc_token
      result = Paymob::PaymentToken.call(
        integration_id:,
        user:,
        amount:,
        commission_fees:
      ).payload
      @payment_token = result[:payment_token]

      response = pay!

      success({ response: }.merge(result))
    end

    private

    def pay!
      response = Faraday.post(
        "#{BASE_URI}/acceptance/payments/pay",
        {
          source: {
            subtype: "TOKEN",
            identifier: @cc_token
          },
          payment_token: @payment_token
        }.to_json,
        "Content-Type" => "application/json"
      )

      raise APIError.new("Something went wrong", http_status: response.status, http_body: response.body) unless response.success?

      JSON.parse(response.body)
    end
  end
end
