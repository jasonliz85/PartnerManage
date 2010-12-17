class WorkPlan < ActiveRecord::Base
	belongs_to :partner
	has_many :weekly_rotas
	has_many :holidays
	
	validates_presence_of :partner_id
end

# == Schema Information
#
# Table name: work_plans
#
#  id               :integer         not null, primary key
#  partner_id       :integer
#  starting_week_no :integer
#  created_at       :datetime
#  updated_at       :datetime
#

