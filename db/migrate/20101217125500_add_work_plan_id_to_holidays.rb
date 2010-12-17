class AddWorkPlanIdToHolidays < ActiveRecord::Migration
  def self.up
  	add_column :holidays, :work_plan_id, :integer
  end

  def self.down
  	remove_column :holidays, :work_plan_id
  end
end
