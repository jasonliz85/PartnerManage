class AddUpdateNeededFieldToBridges < ActiveRecord::Migration
  def self.up
	  add_column :bridges, :update_needed, :boolean , :default => false
  end
  def self.down
  	remove_column :bridges, :update_needed
  end
end
