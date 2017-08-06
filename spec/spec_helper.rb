require 'bacon/colored_output'

require_relative '../lib/bacon/custom_matchers_messages'

def shorter_than(max_size)
	->(obj) { obj.size < max_size }
end

def shorter_than_with_message(max_size)
	[
		->(obj) { obj.size < max_size },
		->(obj) { "#{obj.inspect} not shorter than #{max_size}" }
	]
end
