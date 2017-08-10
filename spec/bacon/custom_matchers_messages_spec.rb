describe Bacon::CustomMatchersMessages do
	string = 'foo bar baz'

	describe 'regular methods' do
		describe 'with one argument' do
			it 'allows use custom matchers as regular without fail' do
				-> { string.should.be shorter_than(20) }
					.should.not.raise
			end

			it 'allows use custom matchers as regular with fail' do
				-> { string.should.be shorter_than(2) }
					.should.raise(Bacon::Error)
					.message.should.be.empty
			end

			it 'allows use custom matchers with custom error messages without fail' do
				-> { string.should.be shorter_than_with_message(20) }
					.should.not.raise
			end

			it 'allows use custom matchers with custom error messages with fail' do
				-> { string.should.be shorter_than_with_message(2) }
					.should.raise(Bacon::Error)
					.message.should.equal '"foo bar baz" doesn\'t shorter than 2'
			end
		end

		describe 'with rest argument' do
			it 'allows use custom matchers as regular without fail' do
				-> { string.should include_words('foo', 'bar') }
					.should.not.raise
			end

			it 'allows use custom matchers as regular with fail' do
				-> { string.should include_words('foo', 'hello') }
					.should.raise(Bacon::Error)
					.message.should.be.empty
			end

			it 'allows use custom matchers with custom error messages without fail' do
				block = lambda do
					string.should.be include_words_with_message_improved('foo', 'bar')
				end
				block.should.not.raise
			end

			it 'allows use custom matchers with custom error messages with fail' do
				block = lambda do
					string.should.be include_words_with_message_improved('foo', 'hello')
				end
				block
					.should.raise(Bacon::Error)
					.message.should.equal '"foo bar baz" doesn\'t include words "hello"'
			end
		end
	end

	describe 'Kernel#custom_matcher' do
		describe 'with one argument' do
			it 'allows use custom matchers with custom error messages without fail' do
				-> { string.should.be shorter_than_generated(20) }
					.should.not.raise
			end

			it 'allows use custom matchers with custom error messages with fail' do
				-> { string.should.be shorter_than_generated(2) }
					.should.raise(Bacon::Error)
					.message.should.equal(
						'"foo bar baz" doesn\'t shorter than generated 2'
					)
			end
		end

		describe 'with rest argument' do
			it 'allows use custom matchers with custom error messages without fail' do
				-> { string.should include_words_generated('foo', 'bar') }
					.should.not.raise
			end

			it 'allows use custom matchers with custom error messages with fail' do
				-> { string.should include_words_generated('foo', 'hello') }
					.should.raise(Bacon::Error)
					.message.should.equal(
						'"foo bar baz" doesn\'t include words generated "foo", "hello"'
					)
			end

			describe 'with message arguments' do
				it 'allows use custom matchers with custom arguments without fail' do
					-> { string.should include_words_generated_improved('foo', 'bar') }
						.should.not.raise
				end

				it 'allows use custom matchers with custom arguments with fail' do
					-> { string.should include_words_generated_improved('foo', 'hello') }
						.should.raise(Bacon::Error)
						.message.should.equal(
							'"foo bar baz" doesn\'t include words generated improved "hello"'
						)
				end
			end
		end
	end
end
