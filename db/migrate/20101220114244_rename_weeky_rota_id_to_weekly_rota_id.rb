class RenameWeekyRotaIdToWeeklyRotaId < ActiveRecord::Migration
  def self.up
  	rename_column :shift_templates, :weeky_rota_id, :weekly_rota_id
  end

  def self.down
  	rename_column :shift_templates, :weekly_rota_id, :weeky_rota_id
  end
end
