class AddHolidayInformationToWorkPlan < ActiveRecord::Migration
  def self.up
    add_column :work_plans, :holiday_entitle, :integer
    add_column :work_plans, :holiday_taken, :integer
  end

  def self.down
    remove_column :work_plans, :holiday_taken
    remove_column :work_plans, :holiday_entitle
  end
end
