require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

