class CalendarController < ApplicationController
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Shift.event_strips_for_month(@shown_month)
  end
  
  def show
  
  	@calendar_date = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
  	
  end
  
end
