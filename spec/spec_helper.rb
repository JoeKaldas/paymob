ENV["RAILS_ENV"] ||= "test"

require "simplecov"
SimpleCov.start

require "dotenv/load"
require "paymob_ruby"
require "generators/paymob_ruby/install_generator"
require "vcr"
require "rspec"

Dir[File.join("./spec", "support", "**", "*.rb")].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.add_formatter "Fuubar"
  config.fuubar_progress_bar_options = {
    format: "[ %c/%C | %p%% ] [%b%i] [ %a | %e ]",
    progress_mark: "#",
    remainder_mark: "-",
    starting_at: 10
  }

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random
  config.disable_monkey_patching!
end

require "webmock/rspec"
WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<API_KEY>") do
    ENV["PAYMOB_API_KEY"]
  end
end
