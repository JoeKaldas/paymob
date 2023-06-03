module Paymob
  class Login < Action
    def call
      url = "#{BASE_URI}/auth/tokens"
      response = ::Faraday.post(url, { api_key: @api_key }.to_json, "Content-Type" => "application/json")

      raise AuthenticationError.new("Invalid API key", http_status: response.status, json_body: response.body) unless response.success?

      response_json = JSON.parse(response.body)
      # @merchant_id = response_json["profile"]["id"]
      response_json["token"]
    end
  end
end
