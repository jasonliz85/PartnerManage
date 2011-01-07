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

  # GET /work_plans/1
  # GET /work_plans/1.xml
  def show
    @work_plan = WorkPlan.where(params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work_plan }
    end
  end

  # GET /work_plans/new
  # GET /work_plans/new.xml
  def new
    @work_plan = WorkPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work_plan }
    end
  end

  # GET /work_plans/1/edit
  def edit
  	#@partner = Partner.find(params[:id])
    @work_plan = WorkPlan.where(params[:id]).first
   
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
    @work_plan = WorkPlan.find(params[:id])

    respond_to do |format|
      if @work_plan.update_attributes(params[:work_plan])
        format.html { redirect_to(@work_plan, :notice => 'Work plan was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work_plan.errors, :status => :unprocessable_entity }
      end
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
