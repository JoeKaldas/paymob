module PaymobRuby
  class PaymentToken
    def call(user:, amount:, integration_id:)
      @login_token = PaymobRuby::Login.call
      @user = user
      @amount = amount.round
      @integration_id = integration_id

      # Paymob order id
      @order_id = order_response["id"]

      payment_key_response["token"]
    end

    private

    def order_response
      @order_response ||= Faraday.post(
        "#{PaymobRuby::BASE_URI}/ecommerce/orders",
        order_body.to_json,
        "Content-Type": "application/json"
      )

      raise Error, "Code: #{@order_response.status}, response: #{@order_response.body}" unless @order_response.success?

      JSON.parse(@order_response.body)
    end

    def payment_key_response
      @payment_key_response ||= Faraday.post(
        "#{PaymobRuby::BASE_URI}/acceptance/payment_keys",
        payment_key_body.to_json,
        "Content-Type": "application/json"
      )

      raise Error, "Code: #{@payment_key_response.status}, response: #{@payment_key_response.body}" unless @payment_key_response.success?

      JSON.parse(@payment_key_response.body)
    end

    def first_name
      @first_name ||= @user.first_name
    end

    def last_name
      @last_name ||= @user.last_name.presence || "NA"
    end

    def phone_number
      @phone_number ||= @user.phone_number
    end

    def email
      @email ||= @user.email
    end

    def order_body
      {
        auth_token: @gateway.login_token,
        delivery_needed: false,
        amount_cents: (@amount * 100).to_i,
        currency: "EGP",
        items: [],
        commission_fees: 0
      }
    end

    def payment_key_body
      {
        auth_token: @login_token,
        amount_cents: (@amount * 100).to_i,
        expiration: 36_000,
        order_id: @order_id,
        billing_data: address_info,
        currency: "EGP",
        card_integration_id: @integration_id
      }
    end

    def address_info
      {
        first_name: first_name,
        last_name: last_name,
        phone_number: phone_number,
        email: email,
        street: "NA",
        building: "NA",
        floor: "NA",
        apartment: "NA",
        postal_code: "NA",
        city: "NA",
        state: "NA",
        country: "EG",
        shipping_method: "PKG"
      }
    end
  end
end
