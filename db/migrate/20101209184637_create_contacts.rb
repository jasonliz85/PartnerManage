class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :partner_id
      t.integer :telephone_no
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :county
      t.string :post_code

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
