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
	
	def update_holiday_variables
		if not self.holiday_booked == self.holidays.count		
			self.holiday_booked = self.holidays.count
		end
	end

	def yearshiftgen(begindate)
		noworkplan = self.weekly_rotas.count
		count = 0
		begindateweeknumber = begindate.cweek
		for weeknom in begindateweeknumber..52 do
				shiftarraygen(self.weekly_rotas[count], weeknom,begindate)
			count = count + 1
				if count > (noworkplan -1)
					count = 0
				end
		end
	end

	def shiftarraygen(weeklyrota, weeknom,begindate)

		shiftentries= Array.new
		weeklyrota.shift_templates.each_with_index do |shift_template, index|
			weekdate = DateTime.commercial(begindate.year, weeknom, index+1) - 1.day
			if shift_template.is_active == true 
				if weekdate.past? == false
				day = weekdate.day
				month = weekdate.mon
				year = weekdate.year

				puts day.to_s + " " + month.to_s + " " + year.to_s
				shiftstart_at = DateTime.new(year,month,day,shift_template.start_at.hour,shift_template.start_at.min)
				shiftend_at = DateTime.new(year,month,day,shift_template.end_at.hour, shift_template.end_at.min)
				shiftentries << {:partner_id => shift_template.weekly_rota.work_plan.partner.id, :name => shift_template.name, :start_at => shiftstart_at,:end_at =>  shiftend_at}
				end
			end
		end
		Shift.create(shiftentries)
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

