RSpec.describe Paymob do
  it "has a version number" do
    expect(Paymob::VERSION).not_to be(nil)
  end

  it { expect(Paymob::BASE_URI).to eq("https://accept.paymobsolutions.com/api") }

  it "is possible to provide config options" do
    described_class.configure do |c|
      expect(c).to eq(described_class)
    end
  end

  describe "parameters" do
    let(:fake_class) { class_double("Paymob") }
    it "is possible to set api_key" do
      expect(fake_class).to receive(:api_key=).with("123.abc")
      fake_class.api_key = "123.abc"
    end
  end
end
