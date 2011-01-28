class Contact < ActiveRecord::Base
	belongs_to :partner
	
	validates :post_code, :format => { :with => /(\b[A-Z]{1,2}[0-9][0-9A-Z]{0,1} {1,}\d[A-Z]{2}\b)/ }
	#validates_presence_of :partner_id
end


# == Schema Information
#
# Table name: contacts
#
#  id            :integer         not null, primary key
#  partner_id    :integer
#  telephone_no  :integer
#  address_line1 :string(255)
#  address_line2 :string(255)
#  city          :string(255)
#  county        :string(255)
#  post_code     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

