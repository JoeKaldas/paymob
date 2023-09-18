require "webmock/rspec"

RSpec.describe PaymobRuby::Login, :vcr do
  let(:result) { described_class.call }

  context "with invalid api key" do
    before do
      PaymobRuby.configure do |config|
        config.api_key = "api_key"
      end
    end

    it_behaves_like "service failure", PaymobRuby::AuthenticationError
  end

  context "with valid api key" do
    before do
      PaymobRuby.configure do |config|
        config.api_key = ENV["PAYMOB_API_KEY"]
      end
    end
    it "returns token" do
      expect(result).to be_success
      expect(result.payload).to be_a(String)
    end
  end
end
