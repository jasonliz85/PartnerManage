class CreateTelephones < ActiveRecord::Migration
  def self.up
    create_table :telephones do |t|
      t.string :number
      t.references :contact

      t.timestamps
    end
  end

  def self.down
    drop_table :telephones
  end
end
