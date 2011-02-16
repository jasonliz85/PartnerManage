class AddColorAndTypeFieldsToShifts < ActiveRecord::Migration
  def self.up
		add_column :shifts, :color, :string
		add_column :shifts, :type, :integer
  end

  def self.down
		remove_column :holidays, :color
		add_column :shifts, :type
  end
end
