class WorkPlansController < ApplicationController
  # GET /work_plans
  # GET /work_plans.xml
  def index
    @work_plans = WorkPlan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @work_plans }
    end
  end

    def populate
    @work_plans = WorkPlan.all

    respond_to do |format|
      format.html # populate.html.erb
      format.xml  { render :xml => @work_plans }
    end
  end

  # GET /work_plans/1
  # GET /work_plans/1.xml
  def show
	@partner = Partner.find(params[:partner_id])
	@work_plan = @partner.work_plan

	respond_to do |format|
		format.html # show.html.erb
		format.xml  { render :xml => @work_plan }
    end
  end

  # GET /work_plans/new
  # GET /work_plans/new.xml
	def new
		@partner = Partner.find(params[:partner_id])
		@work_plan = @partner.work_plan.build

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @work_plan }
		end
	end

  # GET /work_plans/1/edit
	def edit
		@partner = Partner.find(params[:partner_id])
		@work_plan = @partner.work_plan

		if @partner.work_plan.weekly_rotas.empty?
			weekly_plan = @partner.work_plan.weekly_rotas.build
			time_template = DateTime.parse("Sun, 01 Jan 2006 09:00:00 UTC +00:00")
			7.times do |i|
				weekly_plan.shift_templates.build 	:name => @partner.first_name + " " + @partner.last_name,
													:start_at => time_template + i, 
													:end_at => time_template + i + 8.hours
			end
		else
			weekly_rotas = @work_plan.weekly_rotas
		end
	end

  # POST /work_plans
  # POST /work_plans.xml
  def create
    @work_plan = WorkPlan.new(params[:work_plan])

    respond_to do |format|
      if @work_plan.save
        format.html { redirect_to(@work_plan, :notice => 'Work plan was successfully created.') }
        format.xml  { render :xml => @work_plan, :status => :created, :location => @work_plan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /work_plans/1
  # PUT /work_plans/1.xml
	def update
		@partner = Partner.find(params[:partner_id])
		@work_plan = @partner.work_plan

		if @partner.work_plan.update_attributes(params[:work_plan])
			redirect_to(@partner, :notice => 'Work plan was successfully updated.') 
		else
			render :action => "edit"
		end
	end

  # DELETE /work_plans/1
  # DELETE /work_plans/1.xml
  def destroy
    @work_plan = WorkPlan.find(params[:id])
    @work_plan.destroy

    respond_to do |format|
      format.html { redirect_to(work_plans_url) }
      format.xml  { head :ok }
    end
  end
end
