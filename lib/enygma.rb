require_relative "enygma/version"
require_relative "enygma/encryptor"
require_relative "enygma/decryptor"
require_relative "enygma/cracker"
require_relative "enygma/character_mapper"

module Enygma
	class Enigma
		def initialize(operation)
			case operation
			when 'encrypt'
				if ARGV.length == 1
					object = Enygma::Encryptor.new(ARGV[0])
					p object.encrypted
					p object.encryption_key
					p object.encryption_date
					p object.cypher_filename
				else
					puts "Incorrect numberof argument. Ensure you supply only the 'filename' to be encrypted"
				end
			when 'decrypt'
				if ARGV.length == 3
					object = Enygma::Decryptor.new(ARGV[0], ARGV[1], ARGV[2])
					p object.decrypted
					p object.encryption_key
					p object.encryption_date
					p object.plain_filename
				else
					puts "Incorrent number of argument. Ensure you supply the 'filename', 'key' and 'date', in that other"
				end
			else
				puts "Incorrect operation command"
			end

		end
	end
end

Enygma::Enigma.new('decrypt')
# module Enygma
#   # Your code goes here...
# end
