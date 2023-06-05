require "rails/generators"

module Paymob
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Creates a Paymob initializers file."

      def copy_initializer
        copy_file "paymob.rb", "config/initializers/paymob.rb"
      end
    end
  end
end
