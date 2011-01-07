module WorkPlansHelper
	def holidays_left(entitle, taken)
		return if entitle.nil? || taken.nil?
		total_left = entitle - taken
	end
end
