class Holiday < ActiveRecord::Base
	#relationships
	has_event_calendar
	belongs_to :work_plan
	
	#validations
	validates_presence_of :start_at, :end_at, :name
	
	#callbacks
	after_save :update_work_plan
	
	#scopes

	#function definitions
	protected	
		def update_work_plan
			self.work_plan.save
		end
	public
		#finds all the holidays on the given date
		def self.find_all_holidays_on_range(date_from, date_to)
			holidays = Holiday.where("start_at > ? AND start_at < ?", date_from.beginning_of_day(), date_to.end_of_day())		
			return holidays
		end	
end



# == Schema Information
#
# Table name: holidays
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  start_at     :datetime
#  end_at       :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  work_plan_id :integer
#

