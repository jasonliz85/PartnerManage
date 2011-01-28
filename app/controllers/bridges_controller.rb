class BridgesController < ApplicationController
	#bridges index
	def index
		@competencies = Competency.all
		#@partners = Partners.find_all_partners_working_on(DateTime.today)
		respond_to do |format|
			format.html # index.html.erb
		end
	end
end
