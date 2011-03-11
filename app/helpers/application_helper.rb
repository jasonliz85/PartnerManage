module ApplicationHelper
	def simple_date(date)
		date.strftime('%a, %d %b %Y')
		#example format: Mon, 5th Sep 2011
	end
	def simple_date_range(date_from, date_to)
		if date_from.month == date_to.month
			return date_from.strftime('%d-') + date_to.strftime('%d %b %Y')
			#example format: 5th-11th Sep 2011
		else
			return date_from.strftime('%d %b %Y - ') + date_to.strftime('%d %b %Y')
			#example format: 5th Sep 2011 - 7th Oct 2011
		end
	end
	def simple_day_of_week(date)
		date.strftime('%A')
		#example format: Monday
	end
	def simple_weekday_time_range(datetime_start, datetime_end)
		return if datetime_start.nil? || datetime_end.nil?
		date = datetime_start.strftime('%a (%H:%M') + '-' + datetime_end.strftime('%H:%M)')	
		#example format: Mon (9:00-17:00), Tue (9:15-17:15), Wed (10:00-16:00), Thu (9:00-17:00), Friday (9:00-17:00) 
	end
	def simple_start_end_time(datetime_start, datetime_end)
		return if datetime_start.nil? || datetime_end.nil?
		date = datetime_start.strftime(' (%H:%M') + '-' + datetime_end.strftime('%H:%M)')	
		#example format: "(9:15-17:15)"
	end
	def partner_full_name(partner)
		full_name = partner.first_name + " " + partner.last_name
		#example format: John Lewis
	end
	def partner_first_and_last_initial(partner)
		partial_name = partner.first_name + " " + partner.last_name[0].upcase
		#example format: John L
	end
	#sortable table column
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
	end
	#displays a label if not empty
	def display_if_not_empty(label, element)
		if not element.nil? or not element.empty?
			content_tag(:div, :class => "element") do 
				if label.empty? 
					element
				else
					label + ':' + element 
				end
			end
		end
	end
	#used for deleting multiple form entries
	def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
	end
	#used for adding multiple form entries
	def link_to_add_fields(name, f, association)
		new_object = f.object.class.reflect_on_association(association).klass.new
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')" )
	end
	#used to link to a particular day
	def date_link(date)
    link_to(simple_date(date), {:day => date.day, :month => date.month, :year => date.year})
  end
  # custom options for the calendar object
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>"
      #:event_height => @event_height
      #:link_to_day_action => @action
     }
  end
end
