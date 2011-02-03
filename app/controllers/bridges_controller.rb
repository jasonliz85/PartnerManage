class BridgesController < ApplicationController
	#bridges index
	def index
		@competencies = Competency.all
		@partners = Partner.find_all_partners_working_on(Date.today)
		@bridge_list = create_bridge(@partners, @competencies, 3)
		respond_to do |format|
			format.html # index.html.erb
		end
	end
end
