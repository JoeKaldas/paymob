require "webmock/rspec"

RSpec.describe Paymob::Login do
  let(:result) { described_class.call }

  before do
    Paymob.configure do |config|
      config.api_key = "api_key"
    end

    stub_request(:post, "#{Paymob::BASE_URI}/auth/tokens").to_return(status: 403, body: File.read("spec/fixtures/files/login/failure.json"))
  end

  it { expect { result }.to raise_error(Paymob::AuthenticationError) }

  context "with valid api key" do
    before do
      stub_request(:post, "#{Paymob::BASE_URI}/auth/tokens").to_return(status: 201, body: File.read("spec/fixtures/files/login/success.json"))
    end

    it { expect(result).to eq("abc123") }
  end
end
