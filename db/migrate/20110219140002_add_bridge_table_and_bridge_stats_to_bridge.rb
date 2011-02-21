class AddBridgeTableAndBridgeStatsToBridge < ActiveRecord::Migration
  def self.up
  	add_column :bridges, :bridge_table, :text
		add_column :bridges, :bridge_stats, :text
  end

  def self.down
  	remove_column :bridges, :bridge_table
		remove_column :bridges, :bridge_stats
  end
end
