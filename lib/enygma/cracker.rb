require_relative 'mixins/character_mapper'
require_relative 'helpers/offset'
require_relative 'helpers/filer'
require_relative 'helpers/key_gen'
require_relative 'decryptor'

module Enygma
	class Cracker
		PLAIN_LAST_7_CHARACTERS = "..end.."
		def initialize(cypher_filename, encryption_date, plain_filename = nil)
			@cypher_filename = cypher_filename
			@plain_filename = plain_filename
			@encryption_date = encryption_date
			@offset = Offset.get_offset(@encryption_date)
			@decrypted = ""
		end

		def crack
			character_array = Filer.read(@cypher_filename)
			cypher_last_4_characters = character_array.last(4)
			cypher_last_4_characters.rotate!(4 - (character_array.size % 4))

			plain_last_4_characters = PLAIN_LAST_7_CHARACTERS.split('').last(4)
			plain_last_4_characters.rotate!(4 - (character_array.size % 4))

			offset_characters = @offset.split('')

			diff_array = get_difference_array(cypher_last_4_characters, plain_last_4_characters, offset_characters)
			key = KeyGen.get_key(diff_array)

			Decryptor.new(@cypher_filename, key, @encryption_date, @plain_filename).decrypt
		end

		def get_difference_array(cypher_array, plain_array, offset_array)
			difference = []
			4.times do |i|
				diff = Enygma::CHARACTER_MAP.index(cypher_array[i]) - Enygma::CHARACTER_MAP.index(plain_array[i])
				diff -= offset_array[i].to_i

				difference[i] = diff.to_s.rjust(2, '0')
			end

			difference
		end
	end
end
