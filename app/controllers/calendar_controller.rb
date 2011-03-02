class CalendarController < ApplicationController
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
    @event_strips = Shift.event_strips_for_month(@shown_month)
#		start_d, end_d = Shift.get_start_and_end_dates(@shown_month) # optionally pass in @first_day_of_week
#		@events = Shift.events_for_date_range(start_d, end_d)
#		@event_strips = Shift.create_event_strips(start_d, end_d, @events)

  end
  
  def day
  	@calendar_date = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
  	partners = Partner.find_all_partners_working_on(@calendar_date)
  	shifts = Shift.find_all_shifts_on(@calendar_date)
  	@shift_managers, @shift_non_managers, @shift_holidays = sort_managers_holidays_and_partners_from_shifts(shifts)
  	
  	bridge = Bridge.find_bridge_on(@calendar_date)
		if bridge.nil? or bridge.bridge_table.nil? or bridge.bridge_table.empty?
			@bridge_list, @bridge_stats = Bridge.create_bridge!(@calendar_date, @break_slots = 4)
		else
			#bridge.update_bridge!()				
			@bridge_list, @bridge_stats = bridge.get_bridge_info()
			@break_slots = 4
		end
		
  end
  
  private
  	#from shifts, sort all the partners who are managers, non_managers and on holiday
  	def sort_managers_holidays_and_partners_from_shifts(shifts)
  		return [get_all_managers_from_shifts(shifts),
  						Shift.get_all_partners_from(shifts),
  						Shift.get_all_partners_from(shifts)]
  	end 
  	
  	#gets and returns all managers from shift array
  	def get_all_managers_from_shifts(shifts)
  		managers = []
  		shifts.each do |shift|
  			if shift.partner.is_manager  #and not on holiday or absent... etc
  				managers << shift   
  			end
  		end  		
  		return managers
  	end
end
