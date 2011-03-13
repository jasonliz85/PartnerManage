class RenameTypeFieldToShiftTypeInShifts < ActiveRecord::Migration
  def self.up
  	rename_column :shifts, :type, :shift_type
  end

  def self.down
  	rename_column :shifts, :shift_type, :type
  end
end
