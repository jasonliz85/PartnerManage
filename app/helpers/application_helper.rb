module ApplicationHelper
	def simple_date(date)
		date.strftime('%a, %d %b %Y')
		#example format: Mon, 5th Sep 2011
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
end
