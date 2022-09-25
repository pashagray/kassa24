# Kassa24

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/kassa24`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem "kassa24"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install kassa24

## Usage

### Create payment

```ruby
  payment_service = Kassa24::Payment.Create.new
  result = payment_service.call(
    login: "xxx",
    password: "xxx",
    amount: 100_00,
    description: "Payment for order #123",
    customer_data: {
      phone: "+77000000000"
    }
  )

  if result.success?
    result.value[:url] #=> https://kassa24.kz/pay/xxx
  else
    result.error #=> [:bad_credentials, {}]
  end
```

### Callback

```ruby
# E.g. Rails Controller

class Kassa24
  def callback
    callback_service = Kassa24::Callback.new
    callback_service.call(id: request.remote_ip, **params)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kassa24. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/kassa24/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Kassa24 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/kassa24/blob/main/CODE_OF_CONDUCT.md).
