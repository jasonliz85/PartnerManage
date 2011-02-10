class BridgesController < ApplicationController
	#bridges index
	def index
		@competencies = Competency.all
		@partners = Partner.find_all_partners_working_on(Date.today)
		if not @partners.empty?
			@bridge_list = create_bridge(@partners, @competencies, 3)
			#to do:
				#@bridge_stats = get_bridge_stats(@partners, @competencies)
				#bridge_notes = get_bridge_notes
		else
			@bridge_list =[]
		end
		respond_to do |format|
			format.html # index.html.erb
		end
	end
	#helpers
	private
	#this function creats the bridge table format for the bridge page. Each row has one competency and several partners, representing a row in the bridge table
	def create_bridge(partners, competencies, break_slots)
		bridge_row = []
		bridge_row_sasu = []
		bridge_row_task = []
		bridge_row_manager = []
		
		#find managers and separate
		managers, partners = find_all_managers_from(partners)
		if not managers.empty?
			bridge_row_manager << sort_partners_into_breaks(managers, break_slots, "Manager")
		end
		#find cashiers and separate
		cashiers, partners = find_all_partners_with_competency(partners, "Sasu")
		if not cashiers.empty?
			bridge_row_sasu << sort_partners_into_breaks(cashiers, break_slots, "Sasu")
		end
		#find task team members and separate
		task_team_members, partners = find_all_partners_with_competency(partners, "Task Team")
		if not task_team_members.empty?
			bridge_row_task << sort_partners_into_breaks(task_team_members, break_slots, "Task Team")
		end
		#sort all other partners
		competencies.each do |competency|
			if competency.name.downcase == "sasu" or competency.name.downcase == "task team" 
				next
			end
			competent_partners, partners = find_all_partners_with_competency(partners, competency.name)
			bridge_row << sort_partners_into_breaks(competent_partners, break_slots, competency.name)
		end
		#combine results 
		bridge_row = bridge_row_manager + bridge_row + bridge_row_sasu + bridge_row_task
		return bridge_row
	end
	#this function simply finds all the is_manager fields from the partner(s) object
	def find_all_managers_from(partners)
		managers = []
		non_managers =[]
		partners.each do |partner| partner.is_manager ? managers << partner :	non_managers << partner	end		
		return [managers, non_managers]
	end
	#this function finds all the partners who match the input competency
	def find_all_partners_with_competency(partners, competency)
		partners_competent = []
		partners_not_competent = []
		partners.each do |partner| partner.is_competent_at(competency) ? partners_competent << partner :	partners_not_competent << partner	end		
		return [partners_competent, partners_not_competent]
	end
	#this function sorts the given partner objects into the break slots
	#more inteligence in allocating a break slot is needed
	def sort_partners_into_breaks(partners, break_slots, competency)
		foo = []
		partners.each do |partner|
			foo << partner
		end
		return {:competency => competency, :partner => foo}
	end
end
