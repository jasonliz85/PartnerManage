class BridgesController < ApplicationController
	#bridges index
	def index
		@competencies = Competency.all
		respond_to do |format|
			format.html # index.html.erb
		end
	end
end
