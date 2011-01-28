class Shift < ActiveRecord::Base
	#relationships
	has_event_calendar
	#functions
	private
		#finds all the shifts on the given date
		def find_all_shifts_on(date)
			return Shift.where("start_at > ? start_at < ?", date.beginning_of_day(), date.end_of_day())		
		end
end



# == Schema Information
#
# Table name: shifts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#  partner_id :integer
#

