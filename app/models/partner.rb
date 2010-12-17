class Partner < ActiveRecord::Base
	has_one :contact
	has_one :work_plan
	has_many :shifts
	
	validates_presence_of :first_name, :last_name
end

# == Schema Information
#
# Table name: partners
#
#  id          :integer         not null, primary key
#  first_name  :string(255)
#  last_name   :string(255)
#  employee_no :integer
#  is_manager  :boolean
#  is_temp     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

