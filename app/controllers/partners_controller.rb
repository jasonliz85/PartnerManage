class PartnersController < ApplicationController
	helper_method :sort_column, :sort_direction
	
	# GET /partners
  # GET /partners.xml
  def index
    @partners = Partner.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
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
	@partner = Partner.new
	@partner.contact = Contact.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @partner }
    end
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.find(params[:id])
  end

  # POST /partners
  # POST /partners.xml
  def create
    @partner = Partner.new(params[:partner])
    respond_to do |format|
      if @partner.save #and @partner.contact.save
    		 format.html{redirect_to(@partner, :notice => 'Partner was successfully created.')}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @partner.errors, :status => :unprocessable_entity }
      end
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
