require "generator_spec"

RSpec.describe PaymobRuby::Generators::InstallGenerator, type: :generator do
  destination File.expand_path("../tmp", __dir__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates paymob initializer" do
    assert_file "config/initializers/paymob.rb", File.read("lib/generators/paymob_ruby/templates/paymob.rb")
  end
end
