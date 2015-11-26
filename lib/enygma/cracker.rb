require 'enygma/decryptor'
require 'enygma/helpers/filer'
require 'enygma/helpers/key_gen'
require 'enygma/helpers/offset'
require 'enygma/mixins/character_mapper'

module Enygma
  class Cracker
    PLAIN_LAST_7_CHARACTERS = "..end.."

    def initialize(cypher_filename, encryption_date, plain_filename = nil)
      @cypher_filename = cypher_filename
      @plain_filename = plain_filename
      @encryption_date = encryption_date
      @offset = Offset.get_offset(@encryption_date)
      @decrypted = ""
    end

    def crack
      cypher_characters = Filer.read(@cypher_filename)
      cypher_last_4_characters = cypher_characters.last(4)
      cypher_last_4_characters.rotate!(4 - (cypher_characters.size % 4))
      plain_last_4_characters = PLAIN_LAST_7_CHARACTERS.split("").last(4)
      plain_last_4_characters.rotate!(4 - (cypher_characters.size % 4))
      offset_characters = @offset.split("")
      differences = get_differences(
        cypher_last_4_characters,
        plain_last_4_characters,
        offset_characters
      )

      key = KeyGen.get_key(differences)
      Decryptor.new(@cypher_filename, key, @encryption_date, @plain_filename).
        decrypt("cracked")
    end

    def get_differences(cypher_characters, plain_characters, offset_characters)
      differences = []
      4.times do |i|
        diff = Enygma::CHARACTER_MAP.index(cypher_characters[i]) -
          Enygma::CHARACTER_MAP.index(plain_characters[i])

        diff -= offset_characters[i].to_i
        differences[i] = diff.to_s.rjust(2, '0')
      end

      differences
    end
  end
end