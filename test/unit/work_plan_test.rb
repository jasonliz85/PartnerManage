require 'test_helper'

class WorkPlanTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end



# == Schema Information
#
# Table name: work_plans
#
#  id               :integer         not null, primary key
#  partner_id       :integer
#  starting_week_no :integer
#  created_at       :datetime
#  updated_at       :datetime
#  holiday_entitle  :integer
#  holiday_taken    :integer
#  holiday_booked   :integer
#

