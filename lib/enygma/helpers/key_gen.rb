module Enygma
  class KeyGen

		def self.get_key(key_array)
			tracker = []
			key_array.each_with_index do |value, index|
				break if index == key_array.size - 1
				val1 = value
				val2 = key_array[index + 1]
				until val1.to_i >= 100 || tracker[index]
					until val2.to_i >= 100 || tracker[index]
						if val1[1] == val2[0]
							key_array[index] = val1
							key_array[index + 1] = val2
							tracker[index] = true
						else
							val2 = (val2.to_i + Enygma::CHARACTER_MAP.size).to_s
						end
					end
					val2 = key_array[index + 1]
					val1 = (val1.to_i + Enygma::CHARACTER_MAP.size).to_s
				end
			end
			"#{key_array[0]}#{key_array[1][-1]}#{key_array[2][-1]}#{key_array[3][-1]}"
		end

  end
end