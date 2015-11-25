require 'enygma/helpers/filer'
require 'enygma/helpers/offset'
require 'enygma/helpers/rotator'
require 'enygma/mixins/character_mapper'
require 'enygma/mixins/confirmation'

module Enygma
  class Decryptor
    include Confirmation
    attr_reader :plain_filename, :cypher_filename, :encryption_key,
                :encryption_date, :decrypted

    def initialize(
      cypher_filename,
      encryption_key,
      encryption_date,
      plain_filename = nil
    )
      @cypher_filename = cypher_filename
      @plain_filename = plain_filename
      @encryption_key =  encryption_key
      @encryption_date = encryption_date
      @offset = Offset.get_offset(@encryption_date)
      @decrypted = ""
    end

    def decrypt
      begin
        cypher_characters = Filer.read(@cypher_filename)
        cypher_characters.each_slice(4) { |batch| decrypt_batch(batch) }
        @plain_filename = Filer.write(
          @plain_filename,
          @decrypted,
          @cypher_filename,
          "decrypted"
        )

        show_confirmation_message(
          @plain_filename,
          @encryption_key,
          @encryption_date
        )
      rescue StandardError => e
        puts "Could not open the file you supplied."\
        "Make sure you are correctly typing the correct path #{e.message}"
      end
    end

    def decrypt_batch(batch)
      key_characters = @encryption_key.split("")
      offset_characters = @offset.split("")
      batch.each_with_index do |_value, index|
        new_index = Rotator.rotate(
          key_characters[index],
          key_characters[index + 1],
          offset_characters[index],
          batch[index]
        ) { |x, y| x - y }

        @decrypted += Enygma::CHARACTER_MAP[new_index]
      end
    end
  end
end
