class Country < ActiveRecord::Base
  has_many :contacts
end

# == Schema Information
#
# Table name: countries
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#

