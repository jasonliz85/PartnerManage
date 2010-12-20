class AddPartnerIdToShifts < ActiveRecord::Migration
  def self.up
    add_column :shifts, :partner_id, :integer
  end

  def self.down
    remove_column :shifts, :partner_id
  end
end
