class WorkPlan < ActiveRecord::Base
	#relationships
	belongs_to :partner
	has_many :weekly_rotas, :dependent => :destroy
	has_many :holidays, :dependent => :destroy, :order => "start_at ASC"

	accepts_nested_attributes_for :weekly_rotas, :allow_destroy => true #, :reject_if => lambda { |a| a[:]}
	
	#validations
	validates_presence_of :partner_id
	
	#callbacks
	before_save :update_holiday_variables

	#functions
	private
		def update_holiday_variables
			#this function ensures the holiday counter is always up-to-date with the total holidays
			if not self.holiday_booked == self.holidays.count		
				self.holiday_booked = self.holidays.count
			end
		end
		def update_shifts_and_bridges
			#this function changes the shifts_type field in the shift model and changes the update_needed field in the bridge model
		end
	public
		def book_holiday(date_from, date_to, name)
			#book a holiday between two date ranges, first check to see holiday has been booked for given date range
			date_span = date_from..date_to
			holidays = self.holidays.all
			date_span.each do |date|
				holidays.each do |holiday| 
					if holiday.start_at.to_date == date.to_date or holiday.end_at.to_date == date.to_date 		
						return false
					elsif holiday.start_at.to_date < date.to_date and holiday.end_at.to_date > date.to_date 
						return true
					end	
				end
			end
			#find shifts when partner is working, change shift_type field to holiday - 4 - and update created bridges (update_needed? = true)
			shifts = self.partner.shifts.find_shifts_between_dates(date_from, date_to)
			#bridges = Bridge.find_bridge_on_date_range(date_from, date_to)
			return false if shifts.empty?
			holiday_count = 0
			shifts.each do |shift|
				if shift.shift_type == 1
					holiday_count = holiday_count + 1
					shift.update_attributes :shift_type => 4, :color => '#FF6600'
					bridge = Bridge.find_bridge_on_date_range(shift.start_at, shift.end_at)
					if not bridge.empty?
						bridge.update_attributes :update_needed => true, :color => '#FF6600'
					end
				end				
			end				 
			if holiday_count == 0
				return false
			end
			#book holiday in model
			book_holiday = self.holidays.new(:start_at => date_from, :end_at => date_to, :name => name)
			print book_holiday
			if book_holiday.save 			 
				self.holiday_booked = holiday_count
				return true
			else
				return false
			end
		end
		def yearshiftgen(begindate, enddate)
			#this function is responsible for create shifts from the begindate (DateTime) to week 52 of the commercial calendar
			allshift = Array.new
			noworkplan = self.weekly_rotas.count
			count = 0
			begindateweeknumber = begindate.cweek
			enddateweeknumber = enddate.cweek
			if enddate.year > begindate.year 
				enddateweeknumber = enddateweeknumber +52
			end
			puts enddateweeknumber
			for weeknom in begindateweeknumber..enddateweeknumber do
				allshift << shiftarraygen(self.weekly_rotas[count], weeknom,begindate)
				count = count + 1
				if count > (noworkplan - 1)
					count = 0
				end
			end
			partner.delete_shifts_from(begindate)
			Shift.create(allshift)
		end
		#to comment
		def shiftarraygen(weeklyrota, weeknom, begindate)
			shiftentries= Array.new
			if weeknom > 52
				tempweeknom = weeknom - 52
				yearofshift = begindate.year
				yearofshift = yearofshift + 1
			else
				tempweeknom = weeknom
				yearofshift = begindate.year
			end
			weeklyrota.shift_templates.each_with_index do |shift_template, index|
				weekdate = DateTime.commercial(yearofshift, tempweeknom, index+1) - 1.day
				if shift_template.is_active and  (weekdate + 1.day) > begindate
					day, month, year = weekdate.day, weekdate.mon, weekdate.year
					shiftstart_at = DateTime.new(year,month,day,shift_template.start_at.hour,shift_template.start_at.min)
					shiftend_at = DateTime.new(year,month,day,shift_template.end_at.hour, shift_template.end_at.min)
					shiftentries << {:partner_id => shift_template.weekly_rota.work_plan.partner.id, :name => shift_template.name, :start_at => shiftstart_at,:end_at =>  shiftend_at, :shift_type => 1, :color => '#00CC66'}
				end
			end
			return shiftentries
		end
end


# == Schema Information
#
# Table name: work_plans
#
#  id               :integer         not null, primary key
#  partner_id       :integer
#  starting_week_no :integer
#  created_at       :datetime
#  updated_at       :datetime
#  holiday_entitle  :integer
#  holiday_taken    :integer
#  holiday_booked   :integer
#

