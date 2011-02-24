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

	def wizardcompetencyupdate
		@partner = Partner.find(params[:partner_id])
		puts params[:partner][:competency_ids]
		if @partner.update_attributes(params[:partner])
			redirect_to(partner_path(@partner), :notice => 'competency was successfully updated.' )
		else
			render :action => "edit" 
		end
	end


  def competencywizard
		@partner = Partner.find(params[:partner_id])
		respond_to do |format|
			format.html
			format.xml  { render :xml => @competencies }
		end
	end

end
