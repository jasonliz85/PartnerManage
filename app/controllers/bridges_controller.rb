class BridgesController < ApplicationController
	#bridges index
	def index
		@competencies = Competency.all
		@partners = Partner.find_all_partners_working_on(Date.today)
		if not @partners.empty?
			@bridge_list = create_bridge(@partners, @competencies, 3)
		else
			@bridge_list =[]
		end
		respond_to do |format|
			format.html # index.html.erb
		end
	end
	#helpers
	def create_bridge(partners, competencies, break_slots)
		row = []
		competencies.each_with_index do |competency, index|
#			partners.each do
#				
#			end
			row << {:competency => competency, :partner => partners.first}
		end
		puts row
		return row
	end
end
