require_relative 'character_mapper'
module Enygma
	class Encryptor
		#attr_reader :cypher_filename, :encryption_key, :encryption_date, :encrypted
		def initialize(filename, cypher_filename)
			@filename = filename
			@cypher_filename = cypher_filename
			@encryption_key =  rand(10 ** 5).to_s.rjust(5,'0')
			@encryption_date = nil
			@offset = get_offset
			@encrypted = ""

			# encrypt(@filename)
		end

		def get_offset
			@encryption_date =  Time.now.strftime("%d%m%y")
			date_squared = @encryption_date.to_i ** 2

			return (date_squared % 10000).to_s
		end

		def encrypt()
			begin
				@plain_text = File.open(@filename, 'r').read
				plain_characters = @plain_text.split('')

				plain_characters.each_slice(4) do |batch|
					encrypt_batch(batch)
				end
				write_crypt_to_file
				show_confirmation_message
			rescue
				puts "Could not open the file you supplied. Make sure you are correctly typing the correct path"
			end
		end

		def encrypt_batch(batch)
			key_characters = @encryption_key.split('')
			offset_characters = @offset.split('')

			batch.each_with_index do |value, index|
				new_index = get_new_index(key_characters[index], key_characters[index + 1],
					offset_characters[index], batch[index])

				@encrypted += Enygma::CHARACTER_MAP[new_index]
			end
		end

		def get_new_index(key_char1, key_char2, offset_character, character)
			character_index = Enygma::CHARACTER_MAP.index(character)
			total_shift = (key_char1 + key_char2).to_i + offset_character.to_i
			new_character_index = (character_index + total_shift) % Enygma::CHARACTER_MAP.size

			return new_character_index
		end

		def write_crypt_to_file
			#name_split_array = @filename.split('.')
			#@cypher_filename = @cypher_filename # name_split_array.insert(2, 'encrypted').join('.') # filename.encrypted.txt
			File.open(@cypher_filename, "w").write(@encrypted)
		end

		def show_confirmation_message
			puts "created #{@cypher_filename} with key #{@encryption_key} and date #{@encryption_date}"
		end

	end
end