module BridgesHelper
	def create_bridge(partners, competencies, break_slots)
		row = []
		row << {:comptency => competencies.first, :partner => partners.first}
		row << {:comptency => competencies.last, :partner => partners.last}
		return row
	end
end
