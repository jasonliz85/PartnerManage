class CreateWeeklyRotas < ActiveRecord::Migration
  def self.up
    create_table :weekly_rotas do |t|
      t.integer :work_plan_id
      t.integer :sequence_no

      t.timestamps
    end
  end

  def self.down
    drop_table :weekly_rotas
  end
end
