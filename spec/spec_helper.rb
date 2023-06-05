if ENV["RAILS_ENV"] == "test"
  require "simplecov"
  SimpleCov.start
end

require "paymob"

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

  config.include FileManager
end
