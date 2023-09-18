RSpec.describe PaymobRuby do
  it "has a version number" do
    expect(PaymobRuby::VERSION).not_to be(nil)
  end

  it { expect(PaymobRuby::BASE_URI).to eq("https://accept.paymobsolutions.com/api") }

  it "is possible to provide config options" do
    described_class.configure do |c|
      expect(c).to eq(described_class)
    end
  end

  describe "parameters" do
    let(:fake_class) { class_double("PaymobRuby") }
    it "is possible to set api_key" do
      expect(fake_class).to receive(:api_key=).with("123.abc")
      fake_class.api_key = "123.abc"
    end
  end
end
