class Shift < ActiveRecord::Base
	#relationships
	has_event_calendar
	belongs_to :partner
	#scopes
	scope :find_shifts_between_dates, lambda { |date_from, date_to| where("start_at > ? AND start_at < ?", date_from.beginning_of_day(), date_to.end_of_day()) }
	#validations
	validates_presence_of :start_at, :end_at, :name
	#functions
	public
		#finds all the shifts on the given date
		def self.find_all_shifts_on(date)
			shifts = Shift.where("start_at > ? AND start_at < ?", date.beginning_of_day(), date.end_of_day())		
			return shifts
		end
		#check the shift_type field column and returns the partners who are working, not working and a sorted hash list of shift types and partners
		#returns an empty array if no shifts are found and this hash list:
		#{shift_type_1 => [partner_1, ... partner_m], shift_type_2 => [partner_1, ... partner_m], ... , shift_type_n => [partner_1, ... partner_m]},
		def self.find_all_partners_who_are_working_on_date(date)
			shifts = 	find_all_shifts_on(date)
			#shift type listings	
			shift_types_all = 
				{	1 => 'normal', #normal contract hours
					2 => 'normal_plus_overtime', #normal contract hours plus additional hours
					3 => 'overtime', #not part of normal working contract but overtime
					4 => 'holiday', #scheduled holiday
					5 => 'sick', #partner sick
					6 => 'absent_pa', # Paid Authorised (pa) absence
					7 => 'absent_u' # Unauthorised (u) absence
				}
			shifts_working, shifts_not_working, shift_types = [], [], {}
			shift_types_all.each_pair { |key, types|	shift_types[types] =[] }
			if not shifts.empty?
				shifts.each do |shift|
					shift_types[shift_types_all[shift.shift_type]] << extract_partner_and_shift_info(shift)
					if [1,2,3].include?(shift.shift_type)
						shifts_working << shift
					else 
						shifts_not_working << shift
					end
				end
			end
			return [shifts_working, shifts_not_working, shift_types]
		end
		#returns partners from the shift array who have the input type ['Normal', 'Holiday'...etc]
  	def self.get_all_partners_from(shifts)
			shift_types_working = 
			{	1 => 'normal', #normal contract hours
				2 => 'normal_plus_overtime', #normal contract hours plus additional hours
				3 => 'overtime', #not part of normal working contract but overtime
			}	
  		partners = []
  		shifts.each do |shift|
  			if not shift.partner.is_manager and not shift_types_working[shift.shift_type].nil?
  				partners << shift
  			end
  		end
  		return partners
  	end
  	def self.extract_partner_and_shift_info(shift)
			return { 	'start_at' 	=> shift.start_at, 
								'end_at' 		=> shift.end_at,	
								'shift_type'=> shift.shift_type, 
								'first_name'=> shift.partner.first_name, 
								'last_name' => shift.partner.last_name,
								'partner_id'=> shift.partner.id,
								'is_manager'=> shift.partner.is_manager }
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

#	shift_types_working = 
#		{	1 => 'normal', #normal contract hours
#			2 => 'normal_plus_overtime', #normal contract hours plus additional hours
#			3 => 'overtime', #not part of normal working contract but overtime
#		}
#	shift_types_not_working =
#		{
#			4 => 'holiday', #scheduled holiday
#			5 => 'sick', #partner sick
#			6 => 'absent_pa', # Paid Authorised (pa) absence
#			7 => 'absent_u' # Unauthorised (u) absence
#		}


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
#  shift_type :integer         default(1)
#

