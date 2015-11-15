module Enygma
	class Help

		def self.encrypt
			puts "\nTo encrypt a file"
			puts "\nUsage:"
			puts "encrypt <file> [<output>]"
			puts "\nOptions:"
			puts " <file>\t The path to the input file to be encrypted"
			puts " <output>\t (Optional) The path to the output file to save the cypher text. If not provided, the new name will be deduced from the source name"
		end

		def self.decrypt
			puts "\nTo decrypt a file encrypted with 'Enygma'"
			puts "\nUsage:"
			puts "decrypt <cypher-file> [<output>] <key> <date>"
			puts "\nOptions:"
			puts " <cypher-file>\t The path to the input cypher file to be decrypted"
			puts " <output>\t (Optional) The path to the output file to save the plain text. If not provided, the new name will be deduced from the source name"
			puts " <key>\t The key used to encrypt the file"
			puts " <date>\t The date the file was encrypted in this format: ddmmyy (eg. 061115)"
		end
		
		def self.crack
			puts "\nTo crack a file encrypted with 'Enygma', given that you know the \"encryption date\""
			puts "\nUsage:"
			puts "crack <cypher-file> [<output>] <date>"
			puts "\nOptions:"
			puts " <cypher-file>\t The path to the input cypher file to be decrypted"
			puts " <output>\t (Optional) The path to the output file to save the plain text. If not provided, the new name will be deduced from the source name"
			puts " <date>\t The date the file was encrypted in this format: ddmmyy (eg. 061115)"
		end
	end
end