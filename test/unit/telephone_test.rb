require 'test_helper'

class TelephoneTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

