# Paymob

Unofficial Paymob Ruby gem for [Paymob](https://paymob.com/)

## Installation

Install the gem and add to the application's Gemfile by executing:

	$ bundle add paymob

If bundler is not being used to manage dependencies, install the gem by executing:

	$ gem install paymob

Next, you need to run the generator:

  	$ rails generate paymob:install

## Usage

### Configuration

Configure the gem with your configuration

```ruby
PaymobRuby.configure do |config|
  config.api_key = "api_key"
	config.hmac_key = "hmac_key"
end
```

:bulb: You can get your API_KEY from Settings -> Account info -> API Key in your Paymob portal.

For reference on the internals & specifics of Paymob, please head to their official documentation [here](https://docs.paymob.com/)

Any API call will return an object with following methods: 

```ruby
result = PaymobRuby.doSomething
result.success?
result.failure?
result.payload
result.error
```

## Creating a payment:

### Using iframe:

```ruby
user = { first_name: "John", last_name: "Doe", email: "johndoe@test.com", phone_number: "012xxxxxxxxx" }
result = PaymobRuby::PayCard.call(user:, amount: 10, integration_id: 12345678, iframe_id: 123)
```

### Using motto:

```ruby
user = { first_name: "John", last_name: "Doe", email: "johndoe@test.com", phone_number: "012xxxxxxxxx" }
result = PaymobRuby::PayToken.call(user:, amount: 10, integration_id: 12345678, token: "abc123")
```

### Calculating hash
```ruby
 PaymobRuby::Hmac.valid_signature?(paymob_response)
```

## Errors:
Errors could be one of the following:

```ruby
AuthenticationError
InvalidRequestError (With `param` attribute)
APIError
```

## Contributing

Bug reports and pull requests are welcome.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
