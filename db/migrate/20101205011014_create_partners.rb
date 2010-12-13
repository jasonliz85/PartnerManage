class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.string :first_name
      t.string :last_name
      t.integer :employee_no
      t.integer :contact_tel
      t.text :contact_address
      t.string :contact_email
      t.boolean :is_manager
      t.boolean :is_temp

      t.timestamps
    end
  end

  def self.down
    drop_table :partners
  end
end
