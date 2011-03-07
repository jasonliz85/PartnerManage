class Bridge < ActiveRecord::Base
  has_event_calendar
  #validations
	validates_presence_of :start_at, :end_at, :name
	validates :start_at, 	:uniqueness => true
	
  #relationships
  
  #callbacks
  
	#functions
	def update_bridge!()
		#checks whether bridge has been updated (added new shifts) since it was created
		return true		
	end
	def get_bridge_info()
		#returns the bridge table and bridge stats column in the database
		if self.bridge_table.nil? or self.bridge_stats.nil?
			return [false, false]
		else
			return [JSON.parse(self.bridge_table), JSON.parse(self.bridge_stats) ]
		end
	end
	def self.find_bridge_on(date)
		#finds the bridge on the given date
		bridge = Bridge.where("start_at > ? AND start_at < ?", date.beginning_of_day(), date.end_of_day())		
		return bridge.first
	end
	def self.get_partner_object_from_shift(shifts_working)
		#simply returns the partner linked to each shift (i.e. shift.partner)
		partners = []
		shifts_working.each {|shift| partners << shift.partner }
		return partners
	end
	def self.create_bridge!(date, break_slots) 
		b_table, b_stats = create_bridge_table_and_stats(date, break_slots)
		self.create(:name => "Bridge", :start_at => date.beginning_of_day(), :end_at => date.end_of_day(),
								:bridge_table => b_table.to_json, :bridge_stats => b_stats.to_json, :color => '#3366FF' )
		return [b_table, b_stats]
	end
	def self.create_bridge_table_and_stats(date, break_slots)
		#this function creates the bridge table format for the bridge page. 
		#Each row has one competency and several partners, representing a row in the bridge table
		table = {}
		stats = {}
		competencies = Competency.find_all_by_priority(2).map {|f| f.name}
		important_competencies = Competency.find_all_by_priority(1).map {|f| f.name }#['Sasu','Task Team']
		shifts_working, shifts_not_working, shift_types  = Shift.find_all_partners_who_are_working_on_date(date)
		stats['shift_types'] = shift_types
		if not shifts_working.empty?
			partners = get_partner_object_from_shift(shifts_working)
			partners_not_working = get_partner_object_from_shift(shifts_not_working)
			stats['partners_working'] = partners.map{|partner| extract_partner_and_shift_info(partner)}
			stats['partners_not_working'] = partners_not_working.map{|partner| extract_partner_and_shift_info(partner)}
			stats['total_working'] = partners.count
			
			#1.find managers and separate
			table['Manager'] = {}
			managers, partners_left = find_all_managers_from(partners)
			stats['total_managers'] = managers.count
			table['Manager'] = sort_partners_into_breaks(managers, break_slots)

			stats['competencies'] = {}
			#2.find important sections and separate [in Audio and TV: Sasu and Task Team]
			important_competencies.each do |competency|
				table[competency]	= {}		
				partners, partners_left = find_all_partners_with_competency(partners_left, competency)
				stats['competencies'][competency] = partners.count
				table[competency] = sort_partners_into_breaks(partners, break_slots)
			end
			#3.Sort all other partners
			sorted_partners_with_competences = sort_partners_into_competencies(partners_left, competencies, important_competencies)
			sorted_partners_with_competences.each_pair do |competency, partners|
				stats['competencies'][competency] = partners.count
				table[competency] = sort_partners_into_breaks(partners, break_slots)
			end
		end
		return [table, stats]
		#combine results 
		#bridge_row = bridge_row_manager + bridge_row + bridge_row_sasu + bridge_row_task
	end
	protected
		class Array
			#functions (shuffle and shuffle!) which will shuffle randomly an array
			def shuffle
				sort_by { rand }
			end
			def shuffle!
				self.replace shuffle
			end
		end
		def self.extract_partner_and_shift_info(var)
			return {'first_name' 	=> var.first_name, 
							'last_name' 	=> var.last_name,
							'partner_id' 	=> var.id, 
							'is_manager' 	=> var.is_manager }
		end
		def self.find_all_managers_from(partners)
			#this function simply finds all the is_manager fields from the partner(s) object
			managers = []
			non_managers =[]
			partners.each do |partner| partner.is_manager ? managers << extract_partner_and_shift_info(partner):	non_managers << partner	end		
			return [managers, non_managers]
		end
		def self.find_all_partners_with_competency(partners, competency)
			#this function finds all the partners who match the input competency
			partners_competent = []
			partners_not_competent = []
			partners.each do |partner| partner.is_competent_at(competency) ? partners_competent <<  extract_partner_and_shift_info(partner):	partners_not_competent << partner	end		
			return [partners_competent, partners_not_competent]
		end
		def self.sort_partners_into_competencies(partners, sections, excluded_sections)
			#this function sorts and groups a list of partners into a hash of competencies (section)
			#i.e. fits partners into a section	#warning, potential problem if partner.competencies != sections
			#initialise variables
			grouped_partners = {}
			sections.each do |section|
				grouped_partners[section] = []
			end
			#first, find all partners without a competency - add these later
			partners_with_no_competency = []
			partners.each do |partner|
				if partner.competencies.empty?
					partners_with_no_competency << partner
					partners.delete(partner)
				end
			end  
			#now whilst partner list is not empty, loop through each competency 
			#and allocate a partner to this competency
			checked_sections = []
			repeat = true
			while not partners.empty?
				#shuffle competencies
				sections.shuffle!
				while repeat
					#find section with lowest number of partners, if more than one with the lowest
					#then between these lowest numbers choose it at rand
					lowest_sections = []
					set = 0
					grouped_partners.each_pair do |section, list_of_partners|
						if checked_sections.include?(section)
							next #skip
						elsif set == 0
							set = 1
							lowest_sections << section
							next
						elsif list_of_partners.count < grouped_partners[lowest_sections.first].count
							lowest_sections.clear()
							lowest_sections << section
						elsif list_of_partners.count == grouped_partners[lowest_sections.first].count
							lowest_sections << section
						end
					end
					if lowest_sections.count > 1
						current_section =  lowest_sections[rand(lowest_sections.length)]
					else 
						current_section = lowest_sections.first
					end
					#once section chosen, allocate a partner to it's list
					#to do this, loop through the partners list and find a partner with a competency that matches
					#its section
					partners.shuffle!
					partners.each do |partner|
						#skip partners who have only one competency and belong to excluded sections (such as Sasu and Task Team)
						if partner.competencies.count == 1 and excluded_sections.include?(partner.competencies.first.name)
							partners.delete(partner)
							next
						end
						partner.competencies.each do |partner_competency|
							if excluded_sections.include?(partner_competency.name)
								next #skip
							elsif not sections.include?(partner_competency.name)
								#this case must not happen, as it can potentially cause an infinite loop
								return []
							elsif partner_competency.name == current_section
								grouped_partners[current_section] << extract_partner_and_shift_info(partner)#partner.to_json
								#{	:start_at => shift.start_at, :end_at => shift.end_at,	:shift_type => shift.shift_type, }
								partners.delete(partner)
								repeat = false
								break
							end						
						end
						if partner == partners.last
							checked_sections << current_section
						end
					end
					if checked_sections.length == grouped_partners.length
						repeat = false
					end
				end
				checked_sections.clear()
				repeat = true
			end
			#now deal with partners without competencies
			#partners_with_no_competency??
			return grouped_partners
		end
		def self.sort_partners_into_breaks(partners, break_slots)
			#this function sorts the given partner objects into the break slots
			#more intelligence in allocating a break slot is needed
			slots = {}
			shuffled_partners = partners.shuffle!
			for break_no in 1..break_slots do
				slots[break_no] = []
				shuffled_partners.each do |partner|
					if slots[break_no].empty?
						slots[break_no] << partner 
						shuffled_partners.delete(partner)
					end
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

