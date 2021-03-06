class WorkPlan < ActiveRecord::Base
	#relationships
	belongs_to :partner
	has_many :weekly_rotas, :dependent => :destroy
	has_many :holidays, :dependent => :destroy, :order => "start_at ASC"

	accepts_nested_attributes_for :weekly_rotas, :allow_destroy => false #, :reject_if => lambda { |a| a[:]}
	
	#validations
	#validates_presence_of :partner_id
	
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
			pass
		end
	public
		def book_holiday(date_from, date_to, name)
			#book a holiday between two date ranges, first check to see holiday has been booked for given date range
			(date_from..date_to).each do |book_date|
				self.holidays.each do |holiday_range| 
					(holiday_range.start_at.to_date..holiday_range.end_at.to_date).each do |holiday|
						return false if holiday == book_date 
					end
				end
			end
			#find shifts when partner is working, change shift_type field to holiday - 4 - and update created bridges (update_needed? = true)
			shifts = self.partner.shifts.find_shifts_between_dates(date_from, date_to)
			found_bridges = Bridge.find_bridge_on_date_range(date_from, date_to)
			return false if shifts.empty? #no holiday to book
			holiday_count, shifts_to_holidays, bridges_to_update = 0, [], []
			shifts.each do |shift|	
				found_bridges.each do |bridge|
					if bridge.start_at.to_date == shift.start_at.to_date
						bridges_to_update << bridge if not bridge.nil?
					end
				end
				if shift.shift_type == 1 #other cases are also valid
					holiday_count = holiday_count + 1
					shifts_to_holidays << shift
				end				
			end		
			return false if holiday_count == 0
			#book holiday in model
			book_holiday = self.holidays.new(:start_at => date_from, :end_at => date_to, :name => name, :days_taken => holiday_count)
			if book_holiday.save 	
				print "2.bridges_to_update :"
				puts bridges_to_update
				bridges_to_update.each {|b| b.update_attributes(:update_needed => true, :color => '#FF6600')}
				print "shifts_to_holidays :"
				puts shifts_to_holidays
				shifts_to_holidays.each {|shift| shift.update_attributes(:shift_type => 4, :color => '#FF6600')}
				if self.holidays.nil? or self.holidays == 0
					self.holiday_booked = holiday_count
				else		 
					self.holiday_booked = self.holiday_booked + holiday_count
				end
				return true
			else
				return false
			end
		end
		
		def yearshiftgen(begindate, enddate)
			#this function is responsible for create shifts from the begindate (DateTime) to week 52 of the commercial calendar
			allshifts = []
			noworkplan = self.weekly_rotas.count
			count = 0
			begindateweeknumber = begindate.cweek
			enddateweeknumber = enddate.cweek
			if enddate.year > begindate.year 
				enddateweeknumber = enddateweeknumber +52
			end
			for weeknom in begindateweeknumber..enddateweeknumber do
				allshifts.concat(shiftarraygen(self.weekly_rotas[count], weeknom,begindate))
				count = count + 1
				if count > (noworkplan - 1)
					count = 0
				end
			end
			partner.delete_shifts_from(begindate)
			#Shift.create(allshift)
			##!potential performance issue!#
			shifts_not_saved = allshifts.collect{|shift| Shift.new(shift) }
			if shifts_not_saved.all?(&:valid?)
				shifts_not_saved.each(&:save!)
			end
			#Shift.create(allshifts)
		end
		#to comment
		def shiftarraygen(weeklyrota, weeknom, begindate)
			shiftentries = []
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

