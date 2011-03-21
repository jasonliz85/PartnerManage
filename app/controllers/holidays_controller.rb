class HolidaysController < ApplicationController
  # GET /holidays
  # GET /holidays.xml
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
    @partner = Partner.find(params[:partner_id])
    @event_strips = @partner.work_plan.holidays.event_strips_for_month(@shown_month)
  end

  		  def holidaywizard
		@partner = Partner.find(params[:partner_id])
		respond_to do |format|
			format.html
			format.xml  { render :xml => @holidays }
		end
	end

  # GET /holidays/1
  # GET /holidays/1.xml
  def show
   @partner = Partner.find(params[:partner_id])
    @holiday = @partner.work_plan.holidays.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @holiday }
    end
  end

  # GET /holidays/new
  # GET /holidays/new.xml
  def new
  	@partner = Partner.find(params[:partner_id])
  	@work_plan = @partner.work_plan
		@holiday = @partner.work_plan.holidays.build :name => @partner.first_name + " " + @partner.last_name

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @holiday }
    end
  end

  # GET /holidays/1/edit
  def edit
    @partner = Partner.find(params[:partner_id])
    @holiday = @partner.work_plan.holidays.find(params[:id])
  end

  # POST /holidays
  # POST /holidays.xml
  def create
  	@partner = Partner.find(params[:partner_id])
    result = @partner.work_plan.book_holiday(DateTime.parse(params[:holiday][:start_at]), DateTime.parse(params[:holiday][:end_at]), params[:holiday][:name])#.build(params[:holiday])
		if @partner.save and result
			redirect_to(@partner.work_plan.partner, :notice => 'Holiday was successfully created.') 
		else
			render :action => "new" 
		end
  end

  # PUT /holidays/1
  # PUT /holidays/1.xml
  def update
  	@partner = Partner.find(params[:partner_id])
    @holiday = Holiday.find(params[:id])

		if @holiday.update_attributes(params[:holiday])
			if params[:holiday_type] == "single"
				@holiday.end_at = @holiday.start_at
				@holiday.save()
			end
			redirect_to(@holiday.work_plan.partner, :notice => 'Holiday was successfully updated.') 
		else
			render :action => "edit" 
		end
  end

  # DELETE /holidays/1
  # DELETE /holidays/1.xml
  def destroy
    @holiday = Holiday.find(params[:id])
    @holiday.destroy

    respond_to do |format|
      format.html { redirect_to(@holiday.work_plan.partner) }
      format.xml  { head :ok }
      format.js
    end
  end
end
