module Enygma
  class Help
    def self.encrypt
      puts(<<-HERE)

To encrypt a file"

Usage:
encrypt <file> [<output>]

Options:
 <file>\t\t The path to the input file to be encrypted
 <output>\t (Optional) The path to the output file to save the cypher text. If not provided, the new name will be deduced from the source name
HERE
    end

    def self.decrypt
      puts(<<-HERE)

To decrypt a file encrypted with 'Enygma'

Usage:
decrypt <cypher-file> [<output>] <key> <date>

Options:
 <cypher-file>\t The path to the input cypher file to be decrypted
 <output>\t (Optional) The path to the output file to save the plain text. If not provided, the new name will be deduced from the source name
 <key>\t\t The key used to encrypt the file
 <date>\t\t The date the file was encrypted in this format: ddmmyy (eg. 061115)
HERE
    end

    def self.crack
      puts(<<-HERE)

To crack a file encrypted with 'Enygma', given that you know the \"encryption date\"

Usage:
crack <cypher-file> [<output>] <date>

Options:
 <cypher-file>\t The path to the input cypher file to be decrypted
 <output>\t (Optional) The path to the output file to save the plain text. If not provided, the new name will be deduced from the source name
 <date>\t\t The date the file was encrypted in this format: ddmmyy (eg. 061115)
HERE
    end
  end
end