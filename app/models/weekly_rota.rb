class WeeklyRota < ActiveRecord::Base
	belongs_to :work_plan
	has_many :shift_templates
	
	validates_presence_of :work_plan_id
end

# == Schema Information
#
# Table name: weekly_rotas
#
#  id           :integer         not null, primary key
#  work_plan_id :integer
#  sequence_no  :integer
#  created_at   :datetime
#  updated_at   :datetime
#

