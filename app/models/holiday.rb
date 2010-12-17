class Holiday < ActiveRecord::Base
	has_event_calendar
	belongs_to :work_plan
	
	validates_presence_of :work_plan_id
	
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

