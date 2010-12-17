class Shift < ActiveRecord::Base
  has_event_calendar
end

# == Schema Information
#
# Table name: shifts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#

