module Enygma
	class Help

		def self.encrypt
			puts "\nTo encrypt a file"
			puts "\nUsage:"
			puts "\nencrypt <file> [<output>]"
			puts "\n\t <file>\t:\t The path to the input file to be encrypted"
			puts "\n\t <output>\t:\t (Optional) The path to the output file to save the cypher text. If not provided, the new name will be deduced from the source name"
		end

		def self.decrypt
			puts "\nTo decrypt a file encrypted with 'Enygma'"
			puts "\nUsage:"
			puts "\ndecrypt <cypher-file> [<output>] <key> <date>"
			puts "\n\t <cypher-file>\t:\t The path to the input cypher file to be decrypted"
			puts "\n\t <output>\t:\t (Optional) The path to the output file to save the plain text. If not provided, the new name will be deduced from the source name"
			puts "\n\t <key>\t:\t The key used to encrypt the file"
			puts "\n\t <date>\t:\t The date the file was encrypted in this format: ddmmyy (eg. 061115)"
		end
		
		def self.crack
			puts "\nTo crack a file encrypted with 'Enygma', given that you know the \"encryption date\""
			puts "\nUsage:"
			puts "\ncrack <cypher-file> [<output>] <date>"
			puts "\n\t <cypher-file>\t:\t The path to the input cypher file to be decrypted"
			puts "\n\t <output>\t:\t (Optional) The path to the output file to save the plain text. If not provided, the new name will be deduced from the source name"
			puts "\n\t <date>\t:\t The date the file was encrypted in this format: ddmmyy (eg. 061115)"
		end
	end
end