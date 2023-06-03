module PaymobRuby
  class PayToken
    def call(user:, amount:, integration_id:)
      payment_token = Paymob::PaymentToken.call!(
        integration_id: integration_id,
        user: user,
        amount: amount
      ).payload
    end
  end
end
