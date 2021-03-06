require 'pry-byebug'
require 'bacon/colored_output'

require_relative '../lib/bacon/custom_matchers_messages'

## Single argument

## Without message
def shorter_than(max_size)
	->(obj) { obj.size < max_size }
end

## With message
def shorter_than_with_message(max_size)
	lambda do |obj|
		obj.size < max_size ||
			"#{obj.inspect} doesn't shorter than #{max_size}"
	end
end

## With message
custom_matcher :shorter_than_generated do |obj, max_size|
	obj.size < max_size
end

## Rest argument

## Without message
def include_words(*words)
	->(obj) { words.all? { |word| obj.split.include? word } }
end

## With custom message (not-included words)
def include_words_with_message_improved(*words)
	lambda do |obj|
		words.all? { |word| obj.split.include? word } ||
			"#{obj.inspect} doesn't include words" \
			" #{(words - obj.split).map!(&:inspect).join(',')}"
	end
end

## With generated message (all words)
custom_matcher :include_words_generated do |obj, *words|
	words.all? { |word| obj.split.include? word }
end

## With custom message (not-included words)
custom_matcher :include_words_generated_improved do |obj, *words|
	words.all? { |word| obj.split.include? word } ||
		(words - obj.split)
end
