class Bridge < ActiveRecord::Base
  has_event_calendar
  #validations
  #relationships
  #callbacks
	#functions
	def self.find_bridge_on(date)
		#finds the bridge on the given date
		bridge = Bridge.where("start_at > ? AND start_at < ?", date.beginning_of_day(), date.end_of_day())		
		return bridge
	end
	def update_bridge!()
		#checks whether bridge has been updated (added new shifts) since it was created
		return true		
	end
	def get_bridge_info()
		#returns the bridge table and bridge stats column in the database
		return [self.bridge_table, self.bridge_stats ]
	end
	def self.get_partner_object_from_shift(shifts_working)
		#simply returns the partner linked to each shift (i.e. shift.partner)
		partners = []
		shifts_working.each {|shift| partners << shift.partner }
		return partners
	end
	def self.create_bridge!(date, break_slots)
		#this function creats the bridge table format for the bridge page. 
		#Each row has one competency and several partners, representing a row in the bridge table
		table = {}
		stats = {}
		competencies = Competency.all
		shifts_working, shifts_not_working = Shift.find_all_partners_who_are_working_on_date(date)
		if not shifts_working.empty?
			partners = get_partner_object_from_shift(shifts_working)
			partners_not_working = get_partner_object_from_shift(shifts_not_working)
			
			#1.find managers and separate
			table['Manager'] = {}
			managers, partners_left = find_all_managers_from(partners)
			if not managers.empty?
				table['Manager'] = sort_partners_into_breaks(managers, break_slots)
			end
			#2.find important sections and separate [in Audio and TV: Sasu and Task Team]
			important_competencies = ['Sasu','Task Team']
			important_competencies.each do |competency|
				table[competency]	= {}		
				partners, partners_left = find_all_partners_with_competency(partners_left, competency)
				table[competency] = sort_partners_into_breaks(partners, break_slots)
			end
			#3.Sort all other partners
			competencies.each do |competency|
				if not important_competencies.include?(competency.name) 
					table[competency.name]	= {}	
					competent_partners, partners_left = find_all_partners_with_competency(partners_left, competency.name)
					table[competency.name] = sort_partners_into_breaks(competent_partners, break_slots)
				end
			end
		end
		return table
		#combine results 
		#bridge_row = bridge_row_manager + bridge_row + bridge_row_sasu + bridge_row_task
	end
	protected
		def self.find_all_managers_from(partners)
			#this function simply finds all the is_manager fields from the partner(s) object
			managers = []
			non_managers =[]
			partners.each do |partner| partner.is_manager ? managers << partner :	non_managers << partner	end		
			return [managers, non_managers]
		end
		def self.find_all_partners_with_competency(partners, competency)
			#this function finds all the partners who match the input competency
			partners_competent = []
			partners_not_competent = []
			partners.each do |partner| partner.is_competent_at(competency) ? partners_competent << partner :	partners_not_competent << partner	end		
			return [partners_competent, partners_not_competent]
		end
		def self.sort_partners_into_breaks(partners, break_slots)
			#this function sorts the given partner objects into the break slots
			#more inteligence in allocating a break slot is needed
			slots = {}
			for break_no in 1..break_slots do
				slots[break_no] = []
				partners.each do |partner|
					slots[break_no] << partner if slots[break_no].empty?
				end
			end
			return slots
		end
end


# == Schema Information
#
# Table name: bridges
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  start_at     :datetime
#  end_at       :datetime
#  color        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  bridge_table :text
#  bridge_stats :text
#

