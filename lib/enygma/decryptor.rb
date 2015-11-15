require_relative 'mixins/character_mapper'
require_relative 'helpers/offset'
require_relative 'helpers/filer'
require_relative 'helpers/rotator'
require_relative 'mixins/confirmation'
module Enygma
	class Decryptor
		include Confirmation
		#attr_reader :plain_filename, :encryption_key, :encryption_date, :decrypted
		def initialize(cypher_filename, encryption_key, encryption_date, plain_filename = nil)
			@cypher_filename = cypher_filename
			@plain_filename = plain_filename
			@encryption_key =  encryption_key
			@encryption_date = encryption_date
			@offset = Offset.get_offset(@encryption_date)
			@decrypted = ""

			#decrypt(@filename)
		end

		def decrypt
			begin
				cypher_characters = Filer.read(@cypher_filename)

				cypher_characters.each_slice(4) do |batch|
					decrypt_batch(batch)
				end

				output_file = Filer.write(@plain_filename, @decrypted, @cypher_filename, "decrypted")
				show_confirmation_message(output_file, @encryption_key, @encryption_date)
			rescue
				puts "Could not open the file you supplied. Make sure you are correctly typing the correct path"
			end
		end

		def decrypt_batch(batch)
			key_characters = @encryption_key.split('')
			offset_characters = @offset.split('')

			batch.each_with_index do |value, index|
				new_index = Rotator.rotate(key_characters[index], key_characters[index + 1],
					offset_characters[index], batch[index], :-)

				@decrypted += Enygma::CHARACTER_MAP[new_index]
			end
		end

	end
end
