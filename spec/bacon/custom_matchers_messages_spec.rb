describe Bacon::CustomMatchersMessages do
	string = 'Hello!'

	it 'allows use custom matchers as regular without fail' do
		-> { string.should.be shorter_than(10) }
			.should.not.raise
	end

	it 'allows use custom matchers as regular with fail' do
		-> { string.should.be shorter_than(2) }
			.should.raise(Bacon::Error)
			.message.should.be.empty
	end

	it 'allows use custom matchers with custom error messages without fail' do
		-> { string.should.be shorter_than_with_message(10) }
			.should.not.raise
	end

	it 'allows use custom matchers as regular with fail' do
		-> { string.should.be shorter_than_with_message(2) }
			.should.raise(Bacon::Error)
			.message.should.equal '"Hello!" not shorter than 2'
	end
end
