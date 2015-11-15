module Enygma
  class Rotator

      def self.rotate(key_char1, key_char2, offset_character, character, operator)
        character_index = Enygma::CHARACTER_MAP.index(character)
        total_shift = (key_char1 + key_char2).to_i + offset_character.to_i

        (character_index.send(operator, total_shift)) % Enygma::CHARACTER_MAP.size
      end

  end
end