class BridgesController < ApplicationController
	#bridges index
	def index
		@month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
    @event_strips = Bridge.event_strips_for_month(@shown_month)
	end
	#bridge day 
	def day
		@bridge_date = DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
		bridge = Bridge.find_bridge_on(@bridge_date)
		print bridge.nil?
		if bridge.nil? or bridge.empty? or bridge.first.bridge_table.nil? or bridge.first.bridge_table.empty?
			@bridge_list, @bridge_stats = Bridge.create_bridge!(@bridge_date, @break_slots = 4)
		else
			bridge.update_bridge!()				
			@bridge_list, @bridge_stats = bridge.get_bridge_info()
		end
		respond_to do |format|
			format.html # day.html.erb
		end
	end
end


