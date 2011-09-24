class Partner < ActiveRecord::Base
	attr_writer :current_step

	#relationships
	has_one :contact, :dependent => :destroy
	accepts_nested_attributes_for :contact
	has_one :work_plan, :dependent => :destroy
	has_many :shifts
	has_and_belongs_to_many :competencies
	
	#validations
	validates_presence_of :first_name, :last_name, :employee_no
	validates_uniqueness_of :employee_no, :message => 'Employee No must be unique.'
	validates_associated :contact, :work_plan, :shifts
	validates :employee_no, :length => { :maximum => 15 }, :numericality => { :only_integer => true, :message => "Only numbers are allowed for Employee No"}
	validates :first_name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters are allows for First Name" }
	validates :last_name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Only letters are allows for Last Name" }

	#callbacks
	before_save :format_first_last_names
	
	#accepts_nested_attributes_for :work_plan, :allow_destroy => true
	#before_save :create_an_empty_work_plan #possibly change to after_create callback?
	
	private
		def format_first_last_names
			## formatting first and last name (capitalise)
			self.first_name = self.first_name.capitalize
			self.last_name = self.last_name.capitalize
		end
	
	#protected functions
	protected
		def create_an_empty_work_plan
			#create a blank work_plan if a new partner is created
			if self.work_plan.nil?
				self.work_plan = WorkPlan.create()			
			end
		end
		
	public
		def is_competent_at(competency)
			#returns true if a partner has the input competency. note: competency a string name of the competency object
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
		def self.find_all_partners_working_on(date)
			#finds all partners working on a given date
			no_of_shifts = Shift.find_all_shifts_on(date)
			partners = []
			no_of_shifts.each do |shift|
				partners << shift.partner			
			end
			return partners
		end
		def delete_shifts_from(date)
			#this function will delete all future shifts belonging to a partner starting from the date
			self.shifts.where("start_at > ?", date.beginning_of_day).delete_all()
		end
		def self.search(search)
			#searches the partner model
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
			%w[partner contact competency workplan]
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
# Partner.new(:first_name=> 'jSAson', :last_name => 'D$kks', :employee_no => '234324A', :is_manager => True, :is_temp => false)
# Partner.new(:first_name=> 'pEter', :last_name => 'andrews', :employee_no => '234324', :is_manager => true, :is_temp => false)

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

