module Enygma
  class KeyGen
    def self.get_key(differences)
      tracker = []
      differences.each_with_index do |value, index|
        break if index == differences.size - 1
        first_value = value
        second_value = differences[index + 1]

        compare(index, first_value, second_value, tracker, differences)
      end

      "%d%d%d%d" % [
        differences[0],
        differences[1][-1],
        differences[2][-1],
        differences[3][-1]
      ]
    end

    private
    def self.compare(index, first_value, second_value, tracker, differences)
      until first_value.to_i >= 100 || tracker[index]
        until second_value.to_i >= 100 || tracker[index]
          if first_value[1] == second_value[0]
            differences[index] = first_value
            differences[index + 1] = second_value
            tracker[index] = true
          else
            second_value = (second_value.to_i + Enygma::CHARACTER_MAP.size).to_s
          end
        end

        second_value = differences[index + 1]
        first_value = (first_value.to_i + Enygma::CHARACTER_MAP.size).to_s
      end
    end
  end
end