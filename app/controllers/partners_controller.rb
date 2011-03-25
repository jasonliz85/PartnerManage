class PartnersController < ApplicationController
	helper_method :sort_column, :sort_direction
	# GET /partners
  # GET /partners.xml
  def index
    @partners = Partner.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.js 
      format.xml  { render :xml => @partners }
    end
  end

  # GET /partners/1
  # GET /partners/1.xml
  def show
    @partner = Partner.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /partners/new
  # GET /partners/new.xml
  def new
  	session[:partner_params] = session[:partner_step] = nil
  	session[:partner_params] ||= {}
  	session[:workplan_params] = session[:workplan_step] = nil
  	session[:workplan_params] ||= {}
		@partner = Partner.new(session[:partner_params])
		@partner.current_step = session[:partner_step]
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.find(params[:id])
  end

  # POST /partners
  # POST /partners.xml
  def create
  	if params[:cancel_button]
  		session[:partner_step] = session[:partner_params] = nil
  		redirect_to(partners_url)
  		return
  	end
		session[:partner_params].deep_merge!(params[:partner]) if params[:partner]
		
  	print "Partner Info:"
		puts session[:partner_params]

		print "WorkPlan Params - params[:work_plan]: "
		puts params[:work_plan]

		@partner = Partner.new(session[:partner_params])
		@partner.current_step = session[:partner_step]
		
		
		if @partner.valid? 

			if params[:back_button]
				@partner.previous_step
			elsif @partner.last_step?

				if @partner.all_valid?
					@partner.work_plan.update_attributes(params[:work_plan]) if @partner.save 
				end
			else
				@partner.next_step
			end
			
			if @partner.current_step == 'contact'
				@partner.contact = Contact.new(session[:partner_params]["contact_attributes"])
			elsif @partner.current_step == 'workplan'
				@partner.work_plan = WorkPlan.new()
				@work_plan = @partner.work_plan
				weekly_plan = @partner.work_plan.weekly_rotas.build
				time_template = DateTime.parse("Sun, 01 Jan 2006 09:00:00 UTC +00:00")
				7.times do |i|
					weekly_plan.shift_templates.build(:name => @partner.first_name + " " + @partner.last_name,:start_at => time_template + i, :end_at => time_template + i + 8.hours)
				end
			end
			session[:partner_step] = @partner.current_step
			print "Next Step: "
			puts @partner.current_step
		end
		if @partner.new_record?
			render "new"
		else
			session[:partner_step] = session[:partner_params] = nil
			flash[:notice] = "Partner saved!"
			print "Shift Objects?: "
			print @partner.work_plan.weekly_rotas.all 
#			each do |wr|
#				wr.each do |st|
#					print st.start_at
#					print " - "
#					puts st.name
#				end
#			end
			redirect_to @partner
	  end
  end

  # PUT /partners/1
  # PUT /partners/1.xml
	def update
		@partner = Partner.find(params[:id])

		respond_to do |format|
			if @partner.update_attributes(params[:partner]) and @partner.contact.update_attributes(params[:contact])
				format.html { redirect_to(@partner, :notice => 'Partner was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @partner.errors, :status => :unprocessable_entity }
			end
		end
	end

  # DELETE /partners/1
  # DELETE /partners/1.xml
	def destroy
		@partner = Partner.find(params[:id])
		@partner.destroy

		respond_to do |format|
			format.html { redirect_to(partners_url) }
			format.xml  { head :ok }
		end
	end
	private
	#used for sorting by a field name in the partners model
  def sort_column
    Partner.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end
  #used for sorting the order in the partners model
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
