class Holiday < ActiveRecord::Base
	#relationships
	has_event_calendar
	belongs_to :work_plan
	
	#validations
	validates_presence_of :work_plan_id
	
	#callbacks
	after_save :update_work_plan
	
	protected	
		def update_work_plan
			self.work_plan.save
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

