class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
	t.column :c_name, :string, :limit => 128, :null => false

    end
  end

  def self.down
    drop_table :companies
  end
end
