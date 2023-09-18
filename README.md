# Paymob

Unoiffical Paymob Ruby gem for https://paymob.com/

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add paymob

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install paymob

Next, you need to run the generator:

    $ rails generate paymob:install

## Usage

```ruby
Paymob.configure do |config|
  config.api_key = "api_key"
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[joekaldas]/paymob.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
