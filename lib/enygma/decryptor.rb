require_relative 'character_mapper'

module Enygma
	class Decryptor
		attr_reader :plain_filename, :encryption_key, :encryption_date, :decrypted
		def initialize(filename, encryption_key, encryption_date)
			@filename = filename
			@encryption_key =  encryption_key
			@encryption_date = encryption_date
			@offset = get_offset(@encryption_date)
			@decrypted = ""

			#decrypt(@filename)
		end

		def get_offset(date)
			date_squared = date.to_i ** 2

			return (date_squared % 10000).to_s
		end

		def decrypt
			
			file = File.open(@filename, 'r')
			character_array = file.read.split('')

			character_array.each_slice(4) do |batch|
				decrypt_batch(batch)
			end
			write_crypt_to_file(@filename)
			show_confirmation_message
		end

		def show_confirmation_message
			puts "created #{plain_filename} with key #{encryption_key} and date #{encryption_date}"
		end

		def decrypt_batch(batch)
			encryption_key_characters = @encryption_key.split('')
			offset_characters = @offset.split('')
			4.times do |i|
				if batch[i]
					@decrypted += reverse_character(encryption_key_characters, offset_characters, batch, i)
				end
			end
		end

		def write_crypt_to_file(filename)
			name_split_array = filename.split('.')
			# name_split_array[1] = 'decrypted'
			@plain_filename = "decrypted.txt" # name_split_array.join('.') -> filename.decrypted.txt
			File.open(@plain_filename, "w").write(@decrypted)
		end

		def reverse_character(encryption_key_characters, offset_characters, batch, i)
			character_index = Enygma::CHARACTER_MAP.index(batch[i])
			total_shift = (encryption_key_characters[i] + encryption_key_characters[i + 1]).to_i + offset_characters[i].to_i
			new_character_index = (character_index - total_shift) % Enygma::CHARACTER_MAP.size
			# new_character_index = (character_index - total_shift)
			# if new_character_index < 0
			# 	new_character_index = new_character_index.abs
			# 	new_character_index = -(new_character_index  % Enygma::CHARACTER_MAP.size)
			# end
			return Enygma::CHARACTER_MAP[new_character_index]
		end

	end
end

# object = Enygma::Decryptor.new('encrypted.txt', "24782", "121115")
# p object.decrypted
# p object.encryption_key
# p object.encryption_date
# p object.plain_filename