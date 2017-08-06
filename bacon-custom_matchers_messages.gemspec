require_relative 'lib/bacon/custom_matchers_messages/version'

Gem::Specification.new do |spec|
	spec.name          = 'bacon-custom_matchers_messages'
	spec.version       = Bacon::CustomMatchersMessages::VERSION
	spec.authors       = ['Alexander Popov']
	spec.email         = ['alex.wayfer@gmail.com']

	spec.summary       = 'Specify errors messages for `bacon` custom matchers.'
	spec.description   = 'Allows add errors messages for `bacon` custom matchers'
	spec.homepage      =
		'https://github.com/AlexWayfer/bacon-custom_matchers_messages'
	spec.license       = 'MIT'

	spec.files         = `git ls-files -z`.split("\x0").reject do |f|
		f.match(%r{^(test|spec|features)/})
	end
	spec.require_paths = ['lib']

	spec.add_development_dependency 'bundler', '~> 1.15'
	spec.add_development_dependency 'rake', '~> 12'
	spec.add_development_dependency 'bacon', '~> 1.2'
	spec.add_development_dependency 'bacon-colored_output', '~> 1.1'
	spec.add_development_dependency 'pry-byebug', '~> 3.4'
end
