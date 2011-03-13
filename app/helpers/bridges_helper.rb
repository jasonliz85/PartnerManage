module BridgesHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
	def event_calendar_opts_bridge
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>",
      :event_height => 80,
      :link_to_day_action => 'day'#{:day => DateTime.now.day, :month => DateTime.now.month, :year => DateTime.now.year}
     }
  end
  def event_calendar_bridge
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts_bridge do |args|
      event = args[:event]
			event, day = args[:event], args[:day]
			html = %(<a href="/bridges/#{event.start_at.year}/#{event.start_at.month}/#{event.start_at.day}" title="#{h(event.name)}">)
			html << %(#{h(event.name)}</a>)
			html
    end
  end
 
end
