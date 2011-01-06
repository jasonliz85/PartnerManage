module ApplicationHelper
	def simple_date(date)
		date.strftime('%a, %d %b %Y')
		#example format: Mon, 5th Sep 2011
	end
	def simple_weekday_time_range(datetime_start, datetime_end)
		date = datetime_start.strftime('%a (%H:%M') + '-' + datetime_end.strftime('%H:%M)')	
		#example format: Mon (9:00-17:00), Tue (9:15-17:15), Wed (10:00-16:00), Thu (9:00-17:00), Friday (9:00-17:00) 
	end
end
