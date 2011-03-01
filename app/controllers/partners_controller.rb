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
  	session[:partner_params] ||= {}
		@partner = Partner.new(session[:partner_params])
		@partner.contact = Contact.new(session[:partner_params])
		@partner.current_step = session[:partner_step]
		if @partner.current_step == 'basic'
			print 'BASIC'
		elsif @partner.current_step == 'contact'
			print 'CONTACT'
		else 
			print 'DONT KNOW'
		end
#	@partner = Partner.new
#	@partner.contact = Contact.new
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @partner }
#    end
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.find(params[:id])
  end

  # POST /partners
  # POST /partners.xml
  def create
  	session[:partner_params].deep_merge!(params[:partner]) if params[:partner]
		@partner = Partner.new(session[:partner_params])
		@partner.current_step = session[:partner_step]
		if params[:cancel_button]
			session[:partner_step] = session[:partner_params] = nil
			redirect_to partners_path
		else
			if @partner.valid?
				if params[:back_button]
					@partner.previous_step
				elsif @partner.last_step?
					@partner.save if @partner.all_valid?
				else
					@partner.next_step
				end
				session[:partner_step] = @partner.current_step
			end
			if @partner.new_record?
				if @partner.current_step == 'contact'
					@partner.contact = Contact.new()
				elsif @partner.current_step == 'competency'
					@partner.contact = Contact.new()
				end
				render "new"
			else
				session[:partner_step] = session[:partner_params] = nil
				flash[:notice] = "Partner saved!"
				redirect_to @partner
			end
		end
#    @partner = Partner.new(params[:partner])
#    respond_to do |format|
#      if @partner.save #and @partner.contact.save
#    		format.html { redirect_to(@partner, :notice => 'Partner was successfully created.') }
#        format.xml  { render :xml => @partner, :status => :created, :location => @partner }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @partner.errors, :status => :unprocessable_entity }
#      end
#    end
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
