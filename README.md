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

## Old style, without message:

def shorter_than(max_size)
	->(obj) { obj.size < max_size }
end

## Old style, with error message:

def shorter_than(max_size)
	lambda do |obj|
		obj.size < max_size ||
			"#{obj.inspect} doesn't shorter than #{max_size}"
	end
end

## New style, with generated error message:

custom_matcher :shorter_than do |obj, max_size|
	obj.size < max_size
end

## Old style, with custom arguments in message:

def include_words(*words)
	lambda do |obj|
		words.all? { |word| obj.split.include? word } ||
			"#{obj.inspect} doesn't include words" \
			" #{(words - obj.split).map!(&:inspect).join(',')}"
	end
end

## New style, with custom arguments for generated error message:

custom_matcher :include_words do |obj, *words|
	words.all? { |word| obj.split.include? word } ||
		(words - obj.split)
end
```

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at [AlexWayfer/bacon-custom_matchers_messages](https://github.com/AlexWayfer/bacon-custom_matchers_messages).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
