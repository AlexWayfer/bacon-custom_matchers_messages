# Bacon::CustomMatchersMessages

Errors messages for [`bacon`](https://github.com/chneukirchen/bacon) custom matchers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bacon-custom_matchers_messages'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install bacon-custom_matchers_messages
```

## Usage

```ruby
require 'bacon/custom_matchers_messages'

## regular:

def shorter_than(max_size)
	->(obj) { obj.size < max_size }
end

## with error message:

def shorter_than(max_size)
	[
		->(obj) { obj.size < max_size },
		->(obj) { "#{obj.inspect} not shorter than #{max_size}" }
	]
end
```

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at [AlexWayfer/bacon-custom_matchers_messages](https://github.com/AlexWayfer/bacon-custom_matchers_messages).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
