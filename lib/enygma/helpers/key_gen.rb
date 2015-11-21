require "enygma/mixins/character_mapper"
module Enygma
  class KeyGen
    def self.get_key(differences)
      tracker = []
      differences.each_with_index do |value, index|
        break if index == differences.size - 1
        value1 = value
        value2 = differences[index + 1]
        until value1.to_i >= 100 || tracker[index]
          until value2.to_i >= 100 || tracker[index]
            if value1[1] == value2[0]
              differences[index] = value1
              differences[index + 1] = value2
              tracker[index] = true
            else
              value2 = (value2.to_i + Enygma::CHARACTER_MAP.size).to_s
            end
          end
          value2 = differences[index + 1]
          value1 = (value1.to_i + Enygma::CHARACTER_MAP.size).to_s
        end
      end
      "#{differences[0]}#{differences[1][-1]}#{differences[2][-1]}#{differences[3][-1]}"
    end
  end
end