class CreateCompetencies < ActiveRecord::Migration
  def self.up
    create_table :competencies do |t|
      t.string :name
      t.timestamps
    end
    create_table :competencies_partners, :id => false do |t|
		t.references :partner
		t.references :competency
	end
  end

  def self.down
    drop_table :competencies
    drop_table :competencies_partners
  end
end

