class CreateWorkPlans < ActiveRecord::Migration
  def self.up
    create_table :work_plans do |t|
      t.integer :partner_id
      t.integer :starting_week_no

      t.timestamps
    end
  end

  def self.down
    drop_table :work_plans
  end
end
