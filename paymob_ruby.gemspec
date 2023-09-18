# frozen_string_literal: true

require_relative "lib/paymob_ruby/version"

Gem::Specification.new do |spec|
  spec.name = "paymob_ruby"
  spec.version = PaymobRuby::VERSION
  spec.authors = ["Joe Kaldas"]
  spec.email = ["joekaldas8@gmail.com"]

  spec.summary = "Ruby bindings for the Paymob API."
  spec.homepage = "https://github.com/JoeKaldas/paymob"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.3"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(/\A(?:(?:bin|test|spec|features)\/|\.(?:git|travis|circleci)|appveyor)/)
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(/\Aexe\//) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activesupport", "~> 7.0"
  spec.add_dependency "faraday", "~> 2.7.5"
  spec.metadata["rubygems_mfa_required"] = "true"
end
