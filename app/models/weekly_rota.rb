class WeeklyRota < ActiveRecord::Base
	#relationships
	belongs_to :work_plan
	has_many :shift_templates, :dependent => :destroy

	#nested attributes
	accepts_nested_attributes_for :shift_templates, :allow_destroy => true #, :reject_if => lambda { |a| a[:]}
	
	#callbacks
	
	#functions  
	def build_7_shift_templates!(partner)
		time_template = DateTime.parse("Sun, 01 Jan 2006 09:00:00 UTC +00:00")
		7.times do |i|
			self.shift_templates.build(:name => partner.first_name + " " + partner.last_name, :start_at => time_template + i, :end_at => time_template + i + 8.hours)
		end
	end
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

