require "webmock/rspec"

RSpec.describe Paymob::Login, :vcr do
  let(:result) { described_class.call }

  context "with invalid api key" do
    before do
      Paymob.configure do |config|
        config.api_key = "api_key"
      end
    end

    it "raises error" do
      expect(result).to be_failure
      expect(result.payload).to be_nil
      expect(result.error).to be_a(Paymob::AuthenticationError)
    end
  end

  context "with valid api key" do
    before do
      Paymob.configure do |config|
        config.api_key = ENV["PAYMOB_API_KEY"]
      end
    end
    it "returns token" do
      expect(result).to be_success
      expect(result.payload).to be_a(String)
    end
  end
end
