require_relative "character_mapper"

module Enygma
	class Cracker
		def initialize(filename, encryption_date)
			@filename = filename
			@encrypted_text = File.open(filename, 'r').read
			@encryption_date = encryption_date
			@offset = get_offset(@encryption_date)
			@plain_last_7_characters = "..end.."
			@decrypted = ""

		end
		def crack
			character_array = @encrypted_text.split('')
			cypher_last_4_characters_array = character_array.last(4)
			plain_last_4_characters_array = @plain_last_7_characters.split('').last(4)
			offset_characters_array = @offset.split('')
			offset_characters_array.rotate!((@encrypted_text.length % 4) * -1)

			rotation_array = get_rotation_array(cypher_last_4_characters_array, plain_last_4_characters_array, offset_characters_array)
			reverse_rotate_cypher(character_array, rotation_array)
			write_crypt_to_file(@filename)
			show_confirmation_message

			# TODO Trying to get the encryption key here
			rotation = get_key(plain_last_4_characters_array, cypher_last_4_characters_array, offset_characters_array)
			p @key_arr
		end

		# TODO Writing a method to return the rotation values [A, B, C, D]
		def get_key(plain_array, cypher_array, offset_array)
			r_arr = []
			4.times do |i|
				cypher_index = Enygma::CHARACTER_MAP.index(cypher_array[i])
				plain_index =  Enygma::CHARACTER_MAP.index(plain_array[i])
				offset_index = Enygma::CHARACTER_MAP.index(offset_array[i])
				diff = cypher_index - plain_index - offset_index
				r_arr << (diff % (Enygma::CHARACTER_MAP.length ))
			end
			r_arr
		end

		def get_rotation_array(cypher_array, plain_array, offset_array)
			difference = []
			@key_arr = []
			4.times do |i|
				diff = Enygma::CHARACTER_MAP.index(cypher_array[i]) - Enygma::CHARACTER_MAP.index(plain_array[i])
				
				difference << (diff + Enygma::CHARACTER_MAP.length) % Enygma::CHARACTER_MAP.length
			end
			difference.rotate!((@encrypted_text.length % 4) * -1)
			4.times do |i|
				@key_arr[i] = difference[i] - offset_array[i].to_i
			end
		end

		def get_offset(date)
			date_squared = date.to_i ** 2

			return (date_squared % 10000).to_s
		end

		def reverse_rotate_cypher(character_array, rotation_array)
			character_array.each_slice(4) do |batch|
				4.times do |i|
					if batch[i]
						@decrypted += reverse_character(batch, rotation_array, i)
					end
				end
			end
		end

		def write_crypt_to_file(filename)
			#name_split_array = filename.split('.')
			# name_split_array[1] = 'decrypted'
			@plain_filename = "cracked.txt" # name_split_array.join('.') -> filename.decrypted.txt
			File.open(@plain_filename, "w").write(@decrypted)
		end

		def reverse_character(batch, rotation_array, i)
			character_index = Enygma::CHARACTER_MAP.index(batch[i])
			total_shift = rotation_array[i]
			new_character_index = (character_index - total_shift) % Enygma::CHARACTER_MAP.size
			Enygma::CHARACTER_MAP[new_character_index]
		end

		def show_confirmation_message
			puts "created #{@plain_filename} with key #{"unknown"} and date #{@encryption_date}"
		end

	end
end

#Enygma::Cracker.new(ARGV[0], ARGV[1]).crack