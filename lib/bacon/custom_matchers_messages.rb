require_relative 'custom_matchers_messages/version'

module Bacon
	## Extend bacon for errors messages of custom matchers
	module CustomMatchersMessages
		::Should.prepend(
			Module.new do
				## Why so ugly:
				## For regular custom matchers support
				##     .should custom_matcher(args)
				## instead of
				##     .should(*custom_matcher(args))
				def be(*args, &block)
					if args.is_a?(Array) &&
					   args.size == 1 &&
					   args.first.is_a?(Array) &&
					   args.first.size == 2 &&
					   args.first.all? { |arg| arg.is_a? Proc }
						args.flatten!
					end
					super
				end

				def satisfy(description = '', &block)
					## Render received description if it's a Proc
					description = description.call(@object) if description.is_a?(Proc)
					super
				end
			end
		)
	end

	CustomMatchers = Hash.new do |_hash, key|
		raise NameError, "no such custom matcher: #{key.inspect}"
	end

	## Class for generating Array
	## with Proc for checking and Proc for error message
	class CustomMatcher
		def initialize(name, &block)
			@description = name.to_s.tr('_', ' ')
			@block = block
		end

		def to_a(args, &_message_args)
			[
				->(obj) { @block.call(obj, *args) },
				lambda do |obj|
					"#{obj.inspect} doesn't #{@description}" \
					" #{yield(obj, *args).map(&:inspect).join(', ')}"
				end
			]
		end
	end
end

## Add private method into Kernel for custom matchers
module Kernel
	private

	def custom_matcher(name, message_args: ->(_obj, *args) { args }, &block)
		Bacon::CustomMatchers[name] = Bacon::CustomMatcher.new(name, &block)
		define_method name do |*args|
			# binding.pry
			Bacon::CustomMatchers[name].to_a(args, &message_args)
		end
	end
end
