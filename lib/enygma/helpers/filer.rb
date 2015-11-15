module Enygma
  class Filer

		def self.read(filename)
			content = File.open(filename, 'r').read
			content.split('')
		end

		def self.write(dest_file, content, source_file = '', action = '')
			unless dest_file
				name_split_array = source_file.split('.')

				name_split_array.delete("encrypted")
				name_split_array.delete("decrypted")
				name_split_array.delete("cracked")

				dest_file = name_split_array.insert(-2, action).join('.') # filename.encrypted.txt
			end

			File.open(dest_file, "w").write(content)
			dest_file
		end

  end
end