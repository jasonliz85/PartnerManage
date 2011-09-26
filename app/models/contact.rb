class Contact < ActiveRecord::Base
	belongs_to :partner
	
	validates :telephone_no, :format => {:with => /^(\d[ -\.]?)?(\d{3}[ -\.]?)?\d{3}[ -\.]?\d{4}(x\d+)?$/ }
	#validates :post_code, :format => { :with => /(\b[A-Z]{1,2}[0-9][0-9A-Z]{0,1} {1,}\d[A-Z]{2}\b)/ }
	#validates :post_code, :format => { :with => /(((^[BEGLMNS][1-9]\d?) | (^W[2-9] ) | ( ^( A[BL] | B[ABDHLNRST] | C[ABFHMORTVW] | D[ADEGHLNTY] | E[HNX] | F[KY] | G[LUY] | H[ADGPRSUX] | I[GMPV] | JE | K[ATWY] | L[ADELNSU] | M[EKL] | N[EGNPRW] | O[LX] | P[AEHLOR] | R[GHM] | S[AEGKL-PRSTWY] | T[ADFNQRSW] | UB | W[ADFNRSV] | YO | ZE ) \d\d?) | (^W1[A-HJKSTUW0-9]) | (( (^WC[1-2]) | (^EC[1-4]) | (^SW1) ) [ABEHMNPRVWXY] ) ) (\s*)? ([0-9][ABD-HJLNP-UW-Z]{2})) | (^GIR\s?0AA)/ }
	#validates_presence_of :partner_id
end



# == Schema Information
#
# Table name: contacts
#
#  id            :integer         not null, primary key
#  partner_id    :integer
#  telephone_no  :string(20)
#  address_line1 :string(255)
#  address_line2 :string(255)
#  city          :string(255)
#  county        :string(255)
#  post_code     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

