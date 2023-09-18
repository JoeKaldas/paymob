require "webmock/rspec"

RSpec.describe PaymobRuby::PayCard do
  let(:result) { described_class.call(user:, amount:, integration_id:, iframe_id:) }

  let(:user)           { { first_name: "Joe", last_name: "Kaldas", email: "joe@paymob.com", phone_number: "012xxxxxxxxx" } }
  let(:amount)         { 100 }
  let(:integration_id) { ENV["PAYMOB_INTEGRATION_ID"] }
  let(:iframe_id)      { ENV["PAYMOB_IFRAME_ID"] }

  before do
    PaymobRuby.configure do |config|
      config.api_key = ENV["PAYMOB_API_KEY"]
    end
  end

  it "returns payment link", :vcr do
    expect(result).to be_success
    expect(result.payload).to be_a(Hash)
  end

  context "with invalid iFrame ID" do
    let(:iframe_id) { 1 }

    it_behaves_like "service failure", PaymobRuby::InvalidRequestError
  end
end
