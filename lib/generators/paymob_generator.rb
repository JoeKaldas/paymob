class Paymob < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)
  def copy_initializer
    copy_file "paymob.rb", "config/initializers/paymob.rb"
  end
end
