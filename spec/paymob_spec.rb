RSpec.describe Paymob do
  it "has a version number" do
    expect(Paymob::VERSION).not_to be(nil)
  end

  it { expect(Paymob::BASE_URI).to eq("https://accept.paymobsolutions.com/api") }
end
