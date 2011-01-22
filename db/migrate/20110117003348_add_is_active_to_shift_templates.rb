class AddIsActiveToShiftTemplates < ActiveRecord::Migration
  def self.up
  	add_column :shift_templates, :is_active, :boolean
  end

  def self.down
  	remove_column :shift_templates, :is_active
  end
end
