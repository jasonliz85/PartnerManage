class Partner < ActiveRecord::Base
	#validations
	validates_presence_of 		:first_name, :last_name, :employee_no
	validates :employee_no, 	:uniqueness => true
	
	#relationships
	has_one :contact, :dependent => :destroy
	accepts_nested_attributes_for :contact
	has_one :work_plan, :dependent => :destroy
	has_many :shifts
	
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

