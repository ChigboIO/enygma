require_relative 'character_mapper'

module Enygma
	class Decryptor
		#attr_reader :plain_filename, :encryption_key, :encryption_date, :decrypted
		def initialize(cypher_filename, plain_filename, encryption_key, encryption_date)
			@cypher_filename = cypher_filename
			@plain_filename = plain_filename
			@encryption_key =  encryption_key
			@encryption_date = encryption_date
			@offset = get_offset
			@decrypted = ""

			#decrypt(@filename)
		end

		def get_offset
			date_squared = @encryption_date.to_i ** 2

			return (date_squared % 10000).to_s
		end

		def decrypt
			begin
				cypher_text = File.open(@cypher_filename, 'r').read
				cypher_characters = cypher_text.split('')

				cypher_characters.each_slice(4) do |batch|
					decrypt_batch(batch)
				end

				write_crypt_to_file
				show_confirmation_message
			rescue
				puts "Could not open the file you supplied. Make sure you are correctly typing the correct path"
			end
		end

		def decrypt_batch(batch)
			key_characters = @encryption_key.split('')
			offset_characters = @offset.split('')
			
			batch.each_with_index do |value, index|
				new_index = get_new_index(key_characters[index], key_characters[index + 1],
					offset_characters[index], batch[index])

				@decrypted += Enygma::CHARACTER_MAP[new_index]
			end
		end

		def get_new_index(key_char1, key_char2, offset_character, character)
			character_index = Enygma::CHARACTER_MAP.index(character)
			total_shift = (key_char1 + key_char2).to_i + offset_character.to_i
			new_character_index = (character_index - total_shift) % Enygma::CHARACTER_MAP.size

			return new_character_index
		end

		def write_crypt_to_file
			# name_split_array = @plain_filename.split('.')
			# name_split_array[1] = 'decrypted'
			#@plain_filename = "decrypted.txt" # name_split_array.join('.') -> filename.decrypted.txt
			File.open(@plain_filename, "w").write(@decrypted)
		end

		def show_confirmation_message
			puts "created #{@plain_filename} with date #{@encryption_date}"
		end

	end
end
