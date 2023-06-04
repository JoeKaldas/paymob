module Paymob
  class PayCard < Action
    def call(user:, amount:, integration_id:, iframe_id:)
      sanity_checks!
      payment_token = Paymob::PaymentToken.call(
        integration_id: integration_id,
        user: user,
        amount: amount
      )

      "#{Paymob::BASE_URI}/acceptance/iframes/#{iframe_id}?payment_token=#{payment_token}"
    end

    private

    def sanity_checks!; end
  end
end
