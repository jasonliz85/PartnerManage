class AddHolidaysBookedToWorkPlan < ActiveRecord::Migration
  def self.up
  	add_column :work_plans, :holiday_booked, :integer
  end

  def self.down
  	remove_column :work_plans, :holiday_booked
  end
end
