class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
	t.column :club_id, :integer
	t.column :rate, :string
    end
  end

  def self.down
    drop_table :rates
  end
end
