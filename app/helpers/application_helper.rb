module ApplicationHelper
	def simple_date(date)
		date.strftime('%a, %d %b %Y')
		#example format: Mon, 5th Sep 2011
	end
	def simple_weekday_time_range(datetime_start, datetime_end)
		return if datetime_start.nil? || datetime_end.nil?
		date = datetime_start.strftime('%a (%H:%M') + '-' + datetime_end.strftime('%H:%M)')	
		#example format: Mon (9:00-17:00), Tue (9:15-17:15), Wed (10:00-16:00), Thu (9:00-17:00), Friday (9:00-17:00) 
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
		link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
	end
end
