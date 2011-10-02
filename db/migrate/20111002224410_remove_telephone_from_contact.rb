class RemoveTelephoneFromContact < ActiveRecord::Migration
  def self.up
  	remove_column :contacts, :telephone_no
  end

  def self.down
    add_column :contacts, :telephone_no
  end
end
