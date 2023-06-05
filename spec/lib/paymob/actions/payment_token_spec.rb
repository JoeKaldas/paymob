require "webmock/rspec"

RSpec.describe Paymob::PaymentToken do
  let(:result) { described_class.call(user: user, amount: amount, integration_id: integration_id) }

  let(:user)           { {} }
  let(:amount)         { 100 }
  let(:integration_id) { {} }

  before do
    Paymob.configure do |config|
      config.api_key = "your_api_key"
    end

    stub_request(:post, "#{Paymob::BASE_URI}/ecommerce/orders").to_return(status: 200, body: File.read("spec/fixtures/files/login/failure.json"))
  end

  it { expect { result }.to raise_error(Paymob::AuthenticationError) }

  context "with valid api key" do
    before do
      stub_request(:post, "#{Paymob::BASE_URI}/acceptance/payment_keys").to_return(status: 201, body: File.read("spec/fixtures/files/login/success.json"))
    end

    it { expect(result).to eq("abc123") }
  end
end
