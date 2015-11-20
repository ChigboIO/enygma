module Enygma
	class Offset

		def self.get_offset(date)
			date_squared = date.to_i ** 2
			(date_squared % 10000).to_s
		end

	end
end
