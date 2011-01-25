module HolidaysHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>"    }
  end

	def event_calendar
		# args is an argument hash containing :event, :day, and :options
		calendar event_calendar_opts do |args|
			event = args[:event]
			%(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
		end
	end
	#show holiday#index link
	def show_all_holidays(name, work_plan)
		h_entitlement = work_plan.holiday_entitle
		if work_plan.holiday_booked.nil?
			h_booked = work_plan.holidays.count
		else
			h_booked = work_plan.holiday_booked
		end 
		if not h_booked == 0
			if (h_entitlement - h_booked) > 0
				pipe = '|'
			end
			link_to(name, partner_holidays_path(work_plan.partner)) + pipe
		end
	end
	#show holiday#new link
	def show_book_holiday(name, work_plan )
		h_entitlement = work_plan.holiday_entitle
		if work_plan.holiday_booked.nil?
			h_booked = work_plan.holidays.count
		else
			h_booked = work_plan.holiday_booked
		end 
		if (h_entitlement - h_booked) > 0
			link_to(name, new_partner_holiday_path(work_plan.partner))
		end
	end
end
