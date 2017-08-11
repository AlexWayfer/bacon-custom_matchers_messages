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
end

## Add private method into Kernel for custom matchers
module Kernel
	private

	def custom_matcher(name, &_block)
		description = name.to_s.tr('_', ' ')
		define_method name do |*args|
			lambda do |obj|
				result = yield(obj, *args)
				return result if result == true
				"#{obj.inspect} doesn't #{description}" \
					" #{(result || args).map(&:inspect).join(', ')}"
			end
		end
	end
end
