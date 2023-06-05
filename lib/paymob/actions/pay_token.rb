module Paymob
  class PayToken < Action
    def call(user:, amount:, integration_id:, cc_token:)
      @cc_token = cc_token
      result = Paymob::PaymentToken.call(
        integration_id: integration_id,
        user: user,
        amount: amount
      )
      @payment_token = result[:payment_token]

      response = pay!

      { response: response }.merge(result)
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
