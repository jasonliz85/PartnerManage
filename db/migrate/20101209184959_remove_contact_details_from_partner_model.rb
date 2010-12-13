class RemoveContactDetailsFromPartnerModel < ActiveRecord::Migration
  def self.up
  	remove_column :partners, :contact_tel
  	remove_column :partners, :contact_address
  	remove_column :partners, :contact_email
  end

  def self.down
 	add_column :partners, :contact_tel
  	add_column :partners, :contact_address
  	add_column :partners, :contact_email
  end
end
