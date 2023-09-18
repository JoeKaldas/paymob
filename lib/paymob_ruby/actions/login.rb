module PaymobRuby
  class Login < ApplicationService
    def call
      url = "#{BASE_URI}/auth/tokens"
      response = ::Faraday.post(url, { api_key: PaymobRuby.api_key }.to_json, "Content-Type" => "application/json")

      raise AuthenticationError.new("Invalid API key", http_status: response.status, http_body: response.body) unless response.success?

      response_json = JSON.parse(response.body)
      success(response_json["token"])
    end
  end
end
