class ShiftTemplate < ActiveRecord::Base
	has_event_calendar
	belongs_to :weekly_rota
	
	validates_presence_of :weekly_rota_id
end



# == Schema Information
#
# Table name: shift_templates
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  start_at       :datetime
#  end_at         :datetime
#  created_at     :datetime
#  updated_at     :datetime
#  weekly_rota_id :integer
#

