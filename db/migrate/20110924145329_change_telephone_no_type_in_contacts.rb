class ChangeTelephoneNoTypeInContacts < ActiveRecord::Migration
  def self.up
    change_table :contacts do |t|
        t.change :telephone_no, :string, :limit => 20
    end
  end

  def self.down
    change_table :contacts do |t|
        t.change :telephone_no, :integer
    end
  end
end
