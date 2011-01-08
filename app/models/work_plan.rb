class WorkPlan < ActiveRecord::Base
	belongs_to :partner
	has_many :weekly_rotas, :dependent => :destroy
	has_many :holidays, :dependent => :destroy
	accepts_nested_attributes_for :weekly_rotas, :allow_destroy => true #, :reject_if => lambda { |a| a[:]}
	
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
#  holiday_entitle  :integer
#  holiday_taken    :integer
#

