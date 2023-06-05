RSpec.describe Paymob::Generators::InstallGenerator do
  it "installs config file properly" do
    described_class.start
    expect(File.file?(config_file)).to be true
  end
end
