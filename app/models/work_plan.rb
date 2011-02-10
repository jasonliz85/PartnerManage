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
	#this function ensures the holiday counter is always up-to-date with the total holidays
	def update_holiday_variables
		if not self.holiday_booked == self.holidays.count		
			self.holiday_booked = self.holidays.count
		end
	end

	#this function is responsible for create shifts from the begindate (DateTime) to week 52 of the commercial calendar
	def yearshiftgen(begindate, enddate)
		allshift = Array.new
		noworkplan = self.weekly_rotas.count
		count = 0
		begindateweeknumber = begindate.cweek
		enddateweeknumber = enddate.cweek
		
		puts enddate.year
		if enddate.year > begindate.year 
			enddateweeknumber = enddateweeknumber +52
		end
		puts enddateweeknumber
		for weeknom in begindateweeknumber..enddateweeknumber do
			allshift << shiftarraygen(self.weekly_rotas[count], weeknom,begindate)

			count = count + 1
			if count > (noworkplan -1)
				count = 0
			end

		end
		partner.delete_shifts_from(begindate)
		Shift.create(allshift)
	end
	#to comment
	def shiftarraygen(weeklyrota, weeknom, begindate)
		shiftentries= Array.new
			if weeknom >52
				tempweeknom = weeknom - 52
				yearofshift = begindate.year
				yearofshift = yearofshift+1
			else
				tempweeknom = weeknom
				yearofshift = begindate.year
			end
		weeklyrota.shift_templates.each_with_index do |shift_template, index|
			weekdate = DateTime.commercial(yearofshift, tempweeknom, index+1) - 1.day
			if shift_template.is_active and  (weekdate + 1.day) > begindate
				day = weekdate.day
				month = weekdate.mon
				year = weekdate.year
				shiftstart_at = DateTime.new(year,month,day,shift_template.start_at.hour,shift_template.start_at.min)
				shiftend_at = DateTime.new(year,month,day,shift_template.end_at.hour, shift_template.end_at.min)
				shiftentries << {:partner_id => shift_template.weekly_rota.work_plan.partner.id, :name => shift_template.name, :start_at => shiftstart_at,:end_at =>  shiftend_at}
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

