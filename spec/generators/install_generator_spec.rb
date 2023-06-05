require "generators/paymob/install_generator"

RSpec.describe Paymob::Generators::InstallGenerator do
  before :all do
    remove_config
  end

  after :all do
    remove_config
  end

  it "installs config file properly" do
    described_class.start
    expect(File.file?(config_file)).to be true
  end
end
