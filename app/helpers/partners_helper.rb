module PartnersHelper
	#used for adding multiple form entries in the work_plan edit controller
	def link_to_add_weekly_rota(name, f, association, work_plan)
		new_object = f.object.class.reflect_on_association(association).klass.new
		new_object.build_7_shift_templates!(work_plan.partner)
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')" )
	end
end
