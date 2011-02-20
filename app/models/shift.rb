class Shift < ActiveRecord::Base
	#relationships
	has_event_calendar
	belongs_to :partner
	
	#validations
	validates_presence_of :start_at, :end_at, :name
	
	#functions
	public
		#finds all the shifts on the given date
		def self.find_all_shifts_on(date)
			shifts = Shift.where("start_at > ? AND start_at < ?", date.beginning_of_day(), date.end_of_day())		
			return shifts
		end
		#check the shift_type field column and return only the shifts that mean partners are working
		#returns an empty array if no shifts are found
		def self.find_all_partners_who_are_working_on_date(date)
			shifts = 	find_all_shifts_on(date)
			shifts_working = []
			shifts_not_working = []
			if not shifts.empty?
				shifts.each do |shift|
					if [1,2,3].include?(shift.shift_type)
						shifts_working << shift
					else 
						shifts_not_working << shift
					end
				end
			end
			return [shifts_working, shifts_not_working]
		end
end

#shift_type = 
#	[	'normal' => 1, #normal contract hours
#		'normal_plus_overtime' => 2, #normal contract hours plus additional hours
#		'overtime' => 3, #not part of normal working contract
#		'holiday' => 4, #scheduled holiday
#		'sick' => 5, #partner sick
#		'absent_pa' => 6, # Paid Authorised (pa) absence
#		'absent_u' => 7 # Unauthorised (u) absence
#	]

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
#  color      :string(255)
#  shift_type :integer
#

