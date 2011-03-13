module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end

  def event_calendar_shifts
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      %(<a href="/calendar/#{event.start_at.year}/#{event.start_at.month}/#{event.start_at.day}" title="#{h(event.name)}">#{h(event.name)}</a>)
    end
  end
end
