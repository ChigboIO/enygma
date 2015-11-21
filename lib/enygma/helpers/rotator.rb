require "enygma/mixins/character_mapper"
module Enygma
  class Rotator
    def self.rotate(key_character_1, key_character_2, offset_character,
        character
    )
      character_index = Enygma::CHARACTER_MAP.index(character)
      total_shift = (key_character_1 + key_character_2).to_i +
          offset_character.to_i
      rotation = yield(character_index, total_shift)
      rotation % Enygma::CHARACTER_MAP.size
    end
  end
end