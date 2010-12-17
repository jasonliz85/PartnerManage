class CreateShiftTemplates < ActiveRecord::Migration
  def self.up
    create_table :shift_templates do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :shift_templates
  end
end
