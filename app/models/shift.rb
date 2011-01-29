class Shift < ActiveRecord::Base
	#relationships
	has_event_calendar
	belongs_to :partner
	
	#functions
	public
		#finds all the shifts on the given date
		def self.find_all_shifts_on(date)
			shifts = Shift.where("start_at > ? AND start_at < ?", date.beginning_of_day(), date.end_of_day())		
			return shifts
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

