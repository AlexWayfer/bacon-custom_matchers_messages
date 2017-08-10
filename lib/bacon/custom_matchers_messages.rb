require_relative 'custom_matchers_messages/version'

module Bacon
	## Extend bacon for errors messages of custom matchers
	module CustomMatchersMessages
		::Should.prepend(
			Module.new do
				def satisfy(description = '', &block)
					r = yield(@object)
					if r.is_a? String
						description = r
						block = ->(_obj) { false }
					end
					super(description, &block)
				end
			end
		)
	end

	## Class for generating Array
	## with Proc for checking and Proc for error message
	class CustomMatcher
		def initialize(name, &block)
			@description = name.to_s.tr('_', ' ')
			@block = block
		end

		def to_proc_with_message(*args)
			lambda do |obj|
				result = @block.call(obj, *args)
				return result if result == true
				"#{obj.inspect} doesn't #{@description}" \
					" #{(result || args).map(&:inspect).join(', ')}"
			end
		end
	end
end

## Add private method into Kernel for custom matchers
module Kernel
	private

	def custom_matcher(name, &block)
		custom_matcher = Bacon::CustomMatcher.new(name, &block)
		define_method name do |*args|
			custom_matcher.to_proc_with_message(*args)
		end
	end
end
