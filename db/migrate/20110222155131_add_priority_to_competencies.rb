class AddPriorityToCompetencies < ActiveRecord::Migration
  def self.up
	  add_column :competencies, :priority, :integer, :default => 2
  end

  def self.down
  	remove_column :competencies, :priority
  end
end
