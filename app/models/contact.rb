class Contact < ActiveRecord::Base
	#relationships
	belongs_to :partner
	has_many :telephones
	has_one :country
	
	#validations
	validate :is_post_code_valid
	#validates :telephone_no, :format => {:with => /^(\d[ -\.]?)?(\d{3}[ -\.]?)?\d{3}[ -\.]?\d{4}(x\d+)?$/ }
	#validates_presence_of :partner_id
	
	#callbacks
	before_save :format_post_code
	
	public 
		def is_post_code_valid
			pc = UKPostcode.new(self.post_code)
			if not (pc.valid? and pc.full?)
				errors.add(:post_code, "is not a valid post code.")
			end
		end
		
	private
		def format_post_code
			self.post_code = UKPostcode.new(self.post_code).norm
		end		
end


# == Schema Information
#
# Table name: contacts
#
#  id            :integer         not null, primary key
#  partner_id    :integer
#  address_line1 :string(255)
#  address_line2 :string(255)
#  city          :string(255)
#  county        :string(255)
#  post_code     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

