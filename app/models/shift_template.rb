class ShiftTemplate < ActiveRecord::Base
	#validations 
	
	#relationship
	has_event_calendar
	belongs_to :weekly_rota
	
	#callbacks
	#before_save :make_explicit_is_active, :end_at_later_than_start_at
	
	#protected functions
	protected
		#this function ensures that the end_at time is always after the start_at time
		def end_at_later_than_start_at
			if self.is_active == true and self.start_at > self.end_at
					return false
			end
		end
		#this function esures that is_active will contain a boolean type, initialised at false
		def make_explicit_is_active
			if self.is_active.nil?
				self.is_active = false
			end
		end
end





# == Schema Information
#
# Table name: shift_templates
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  start_at       :datetime
#  end_at         :datetime
#  created_at     :datetime
#  updated_at     :datetime
#  weekly_rota_id :integer
#  is_active      :boolean
#

