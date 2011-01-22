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

