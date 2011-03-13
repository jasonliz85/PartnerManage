class AddColorAndTypeFieldsToShifts < ActiveRecord::Migration
  def self.up
		add_column :shifts, :color, :string
		add_column :shifts, :type, :integer, :default => 1
  end

  def self.down
		remove_column :holidays, :color
		remove_column :shifts, :type
  end
end
