# require "webmock/rspec"

RSpec.describe Paymob::Login do
  let(:result) { described_class.call }

  before do
    Paymob.configure do |config|
      config.api_key = "api_key"
    end
  end

  it "raises error on invalid api key" do
    expect(result).to raise_error(Paymob::AuthenticationError)
  end

  # it "returns a Xero invoice" do
    # expect(CustomerSuccessNotifier).to_not receive(:slack)
    # expect(result).to be_success
    # expect(payload).to be_a(XeroRuby::Accounting::Invoice)
  # end

  # context "with renewal not pending" do
  #   let!(:renewal) { create(:renewal, :invoiced) }
  #   it { expect { result }.to raise_error(Xero::CreateInvoice::Error) }
  # end

  # context "without renewal" do
  #   let!(:renewal) { nil }
  #   it { expect { result }.to raise_error(Xero::CreateInvoice::Error) }
  # end
end
