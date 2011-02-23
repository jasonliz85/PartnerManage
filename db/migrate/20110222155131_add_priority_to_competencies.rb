class AddPriorityToCompetencies < ActiveRecord::Migration
  def self.up
	  add_column :competencies, :priority, :integer
  end

  def self.down
  	remove_column :competencies, :priority
  end
end
