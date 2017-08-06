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
end
