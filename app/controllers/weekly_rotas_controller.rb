class WeeklyRotasController < ApplicationController
  # GET /weekly_rotas
  # GET /weekly_rotas.xml
  def index
    @weekly_rotas = WeeklyRota.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weekly_rotas }
    end
  end

  # GET /weekly_rotas/1
  # GET /weekly_rotas/1.xml
  def show
    @weekly_rota = WeeklyRota.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weekly_rota }
    end
  end

  # GET /weekly_rotas/new
  # GET /weekly_rotas/new.xml
  def new
    @weekly_rota = WeeklyRota.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weekly_rota }
    end
  end

  # GET /weekly_rotas/1/edit
  def edit
    @weekly_rota = WeeklyRota.find(params[:id])
  end

  # POST /weekly_rotas
  # POST /weekly_rotas.xml
  def create
    @weekly_rota = WeeklyRota.new(params[:weekly_rota])

    respond_to do |format|
      if @weekly_rota.save
        format.html { redirect_to(@weekly_rota, :notice => 'Weekly rota was successfully created.') }
        format.xml  { render :xml => @weekly_rota, :status => :created, :location => @weekly_rota }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weekly_rota.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weekly_rotas/1
  # PUT /weekly_rotas/1.xml
  def update
    @weekly_rota = WeeklyRota.find(params[:id])

    respond_to do |format|
      if @weekly_rota.update_attributes(params[:weekly_rota])
        format.html { redirect_to(@weekly_rota, :notice => 'Weekly rota was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weekly_rota.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_rotas/1
  # DELETE /weekly_rotas/1.xml
  def destroy
    @weekly_rota = WeeklyRota.find(params[:id])
    @weekly_rota.destroy

    respond_to do |format|
      format.html { redirect_to(weekly_rotas_url) }
      format.xml  { head :ok }
    end
  end
end
