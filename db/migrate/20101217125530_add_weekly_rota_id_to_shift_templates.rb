class AddWeeklyRotaIdToShiftTemplates < ActiveRecord::Migration
  def self.up
  	add_column :shift_templates, :weeky_rota_id, :integer
  end

  def self.down
	remove_column :shift_templates, :weeky_rota_id
  end
end
