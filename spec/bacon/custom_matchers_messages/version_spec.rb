version_constant = Bacon::CustomMatchersMessages::VERSION

describe version_constant do
	it 'should be kind of String' do
		version_constant.should.be.kind_of String
	end
end
