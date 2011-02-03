class Partner < ActiveRecord::Base
	#validations
	validates_presence_of 		:first_name, :last_name, :employee_no
	validates :employee_no, 	:uniqueness => true
	
	#relationships
	has_one :contact, :dependent => :destroy
	accepts_nested_attributes_for :contact
	has_one :work_plan, :dependent => :destroy
	has_many :shifts
	has_and_belongs_to_many :competencies
	
	#callbacks
	before_save :create_an_empty_work_plan #possibly change to after_create callback?
	
	#protected functions
	protected
		#create a blank work_plan if a new partner is created
		def create_an_empty_work_plan
			if self.work_plan.nil?
				self.work_plan = WorkPlan.create()			
			end
		end
	public
		#finds all partners working on a given date
		def self.find_all_partners_working_on(date)
			no_of_shifts = Shift.find_all_shifts_on(date)
			partners = []
			no_of_shifts.each do |shift|
				partners << shift.partner			
			end
			return partners
		end

		public
		
		def shiftdelete(begindate)
#			beginday = begindate.day
#			beginmonth = begindate.month
#			beginyear = begindate.year

#			begindate = DateTime.new(beginyear,beginmonth,beginday)
			self.shifts.where("start_at > ?", begindate.beginning_of_day+1.day).delete_all
#			self.shifts.delete_all("start_at > begindate")
		end
end


# == Schema Information
#
# Table name: partners
#
#  id          :integer         not null, primary key
#  first_name  :string(255)
#  last_name   :string(255)
#  employee_no :integer
#  is_manager  :boolean
#  is_temp     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

