require "webmock/rspec"

RSpec.describe Paymob::PaymentToken do
  let(:result) { described_class.call(user:, amount:, integration_id:, commission_fees:) }

  let(:defaults)        { { first_name: "Joe", last_name: "Kaldas", email: "joe@paymob.com", phone_number: "012xxxxxxxxx" } }
  let(:user)            { defaults }
  let(:amount)          { 100 }
  let(:commission_fees) { 10 }
  let(:integration_id)  { ENV["PAYMOB_INTEGRATION_ID"] }

  before do
    Paymob.configure do |config|
      config.api_key = ENV["PAYMOB_API_KEY"]
    end
  end

  it "returns payment token", :vcr do
    expect(result).to be_success
    expect(result.payload).to be_a(Hash)
  end

  context "with missing first name" do
    let(:user) { defaults.except(:first_name) }

    it_behaves_like "service failure", Paymob::InvalidRequestError
  end

  context "with missing last name" do
    let(:user) { defaults.except(:last_name) }

    it_behaves_like "service failure", Paymob::InvalidRequestError
  end

  context "with missing email" do
    let(:user) { defaults.except(:email) }

    it_behaves_like "service failure", Paymob::InvalidRequestError
  end

  context "with negative amount" do
    let(:amount) { -1 }

    it_behaves_like "service failure", Paymob::InvalidRequestError
  end

  context "with negative commission fees" do
    let(:commission_fees) { -1 }

    it_behaves_like "service failure", Paymob::InvalidRequestError
  end
end
