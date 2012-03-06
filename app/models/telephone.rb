class Telephone < ActiveRecord::Base
  belongs_to :contact
  #validates :telephone_no, :format => {:with => /^(\d[ -\.]?)?(\d{3}[ -\.]?)?\d{3}[ -\.]?\d{4}(x\d+)?$/ }
  
end

# == Schema Information
#
# Table name: telephones
#
#  id         :integer         not null, primary key
#  number     :string(255)
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#

