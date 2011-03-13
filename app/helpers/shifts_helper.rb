module ShiftsHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  def shift_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      %(<a href="/partners/#{@partner.id}/work_plan" title="#{h(event.name)}">#{h(event.name)}</a>)
    end
  end
end
