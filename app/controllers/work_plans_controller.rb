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
  	#work_plan = @partner.work_plan.find(params[:id])
    #@work_plan = WorkPlan.where(params[:id])[0]
	@partner = Partner.find(params[:partner_id])
	@work_plan = @partner.work_plan
	#@work_plan = Partner.find(params[:id]).work_plan

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
			puts "Emtpy"
			weekly_plan = @partner.work_plan.weekly_rotas.build
			time_template = DateTime.parse("Sun, 01 Jan 2006 09:00:00 UTC +00:00")
			7.times do |i|
				weekly_plan.shift_templates.build 	:name => @partner.first_name + " " + @partner.last_name,
													:start_at => time_template + i, 
													:end_at => time_template + i + 8.hours
			end
		else
			puts "Not Empty"
			weekly_rotas = @work_plan.weekly_rotas
#			for weekly_rota in weekly_rotas
##				for shift_template in weekly_rota.shift_templates
##					puts shift_template.start_at
##				end
#				7.times do |i|
#					weekly_rota.shift_templates.build 	:name => @partner.first_name + " " + @partner.last_name,
#														:start_at => weekly_rota.shift_templates[i].start_at, 
#														:end_at => weekly_rota.shift_templates[i].end_at
#				end
#			end
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

#		weekly_plans = params[:work_plan][:weekly_rotas_attributes]
#		weekly_rotas = @work_plan.weekly_rotas
#		for plan in weekly_plans
#			weekly_plan = plan[:shift_templates_attributes]
#			weekly_plan.each_with_index do |shift, index|
#				puts shift
#			end
#		end 
		#params[:partner_id2]
		if @partner.work_plan.update_attributes(params[:work_plan])
			redirect_to(@partner, :notice => 'Work plan was successfully updated.') 
		else
			render :action => "edit"
		end
#		respond_to do |format|
#			if @partner.work_plan.update_attributes(params[:work_plan])
#				format.html { redirect_to(partner_work_plan(@partner), :notice => 'Work plan was successfully updated.') }
#				format.xml  { head :ok }
#			else
#				format.html { render :action => "edit" }
#				format.xml  { render :xml => @partner.work_plan.errors, :status => :unprocessable_entity }
#			end
#		end
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
