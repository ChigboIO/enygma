require_relative 'character_mapper'
module Enygma
	class Encryptor
		attr_reader :cypher_filename, :encryption_key, :encryption_date, :encrypted
		def initialize(filename)
			@encryption_key =  rand(10 ** 5).to_s.rjust(5,'0')
			@encryption_date = nil
			@offset = get_offset
			@encrypted = ""

			encrypt(filename)
		end
		def encrypt(filename)
			file = File.open(filename, 'r')
			character_array = file.read.split('')

			character_array.each_slice(4) do |batch|
				encrypt_batch(batch)
			end
			write_crypt_to_file(filename)
		end

		def write_crypt_to_file(filename)
			name_split_array = filename.split('.')
			@cypher_filename = "encrypted.txt" #name_split_array.insert(2, 'encrypted').join('.')
			File.open(@cypher_filename, "w").write(@encrypted)
		end

		def encrypt_batch(batch)
			encryption_key_characters = @encryption_key.split('')
			offset_characters = @offset.split('')
			4.times do |i|
				if batch[i]
					@encrypted += rotate_character(encryption_key_characters, offset_characters, batch, i)
				end
			end
		end

		def rotate_character(encryption_key_characters, offset_characters, batch, i)
			character_index = Enygma::CHARACTER_MAP.index(batch[i])
			total_shift = (encryption_key_characters[i] + encryption_key_characters[i + 1]).to_i + offset_characters[i].to_i
			new_character_index = (character_index + total_shift) % Enygma::CHARACTER_MAP.size
			return Enygma::CHARACTER_MAP[new_character_index]
		end

		def get_offset
			@encryption_date =  Time.now.strftime("%d%m%y")
			date_squared = @encryption_date.to_i ** 2

			return (date_squared % 10000).to_s
		end
	end
end

# object = Enygma::Encryptor.new('test_file.txt')
# p object.encrypted
# p object.encryption_key
# p object.encryption_date
# p object.cypher_filename