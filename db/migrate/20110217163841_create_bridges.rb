class CreateBridges < ActiveRecord::Migration
  def self.up
    create_table :bridges do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.string :color
      
      t.timestamps
    end
  end

  def self.down
    drop_table :bridges
  end
end
