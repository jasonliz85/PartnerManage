class AddDaysTakenToHolidays < ActiveRecord::Migration
	def self.up
	  add_column :holidays, :days_taken, :integer , :default => 0
  end
  def self.down
  	remove_column :holidays, :days_taken
  end
end
