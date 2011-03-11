class Competency < ActiveRecord::Base
	#relationships	
	has_and_belongs_to_many :partners
	#ordering
	default_scope order('competencies.name')
	
	#functions
end



# == Schema Information
#
# Table name: competencies
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  priority   :integer
#

