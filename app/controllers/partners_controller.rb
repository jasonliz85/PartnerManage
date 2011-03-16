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
		session[:partner_params].deep_merge!(params[:partner]) if params[:partner]
  	print "Partner Info:"
		puts params[:partner]
		print "Session Info:"
		puts session[:partner_params]

		@partner = Partner.new(session[:partner_params])
		@partner.current_step = session[:partner_step]
		
#		if @partner.current_step == 'newcontact'
#			@partner.contact = Contact.new(params[:partner])
#			print "Contact Object Saved? "
#			puts @partner.valid?
#		end

		if @partner.valid?
			print "Current Step: "
			puts @partner.current_step
			if params[:back_button]
				@partner.previous_step
			elsif @partner.last_step?
				@partner.save if @partner.all_valid?
			else
				@partner.next_step
			end
			session[:partner_step] = @partner.current_step
			if @partner.current_step == 'newcontact'
				@partner = Partner.new(session[:partner_params])
				print "Partner.contact: "
				puts @partner.contact
			end
		end
		if @partner.new_record?
			render "new"
		else
			session[:partner_step] = session[:partner_params] = nil
			flash[:notice] = "Partner saved!"
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
