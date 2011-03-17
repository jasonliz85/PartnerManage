class Partner < ActiveRecord::Base
	attr_writer :current_step
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
		#returns true if a partner has the input competency. note: competency a string name of the competency object
		def is_competent_at(competency)
			if self.competencies.nil? 
				return false
			end
			self.competencies.each do |their_competency|
				if their_competency.name.downcase == competency.downcase
					return true 
				end
			end			
			return false			
		end
		#finds all partners working on a given date
		def self.find_all_partners_working_on(date)
			no_of_shifts = Shift.find_all_shifts_on(date)
			partners = []
			no_of_shifts.each do |shift|
				partners << shift.partner			
			end
			return partners
		end
		#this function will delete all future shifts belonging to a partner starting from the date
		def delete_shifts_from(date)
			self.shifts.where("start_at > ?", date.beginning_of_day).delete_all()
		end
		#searches the partner model
		def self.search(search)
			if search
				where('first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%")
			else
				scoped
			end
		end

		def current_step
			@current_step || steps.first
		end

		def steps
			%w[partner contact competency]
		end

		def next_step
			self.current_step = steps[steps.index(current_step)+1]
		end

		def previous_step
			self.current_step = steps[steps.index(current_step)-1]
		end

		def first_step?
			current_step == steps.first
		end

		def last_step?
			current_step == steps.last
		end
		
		def all_valid?
  		steps.all? do |step|
  	  	self.current_step = step
  	  	valid?
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

