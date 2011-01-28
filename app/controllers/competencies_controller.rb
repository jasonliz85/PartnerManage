class CompetenciesController < ApplicationController
	# GET /competency/edit
	def edit
		@partner = Partner.find(params[:partner_id])
	end

	# PUT /competency/1
	# PUT /competency/1.xml
	def update
		@partner = Partner.find(params[:partner_id])

		if @partner.competency.update_attributes(params[:competency])
			redirect_to( @partner, :notice => 'competency was successfully updated.' )
		else
			render :action => "edit" 
		end
	end

end
