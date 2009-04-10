class CreateFaculties < ActiveRecord::Migration
  def self.up
    create_table :faculties do |t|
	t.column :email, :string, :limit => 128, :null => false
	t.column :hashed_password, :string, :limit => 64
	t.column :fac_displayname, :string, :limit => 64, :null => false
	t.column :fac_title, :string, :limit => 64, :null => false
	t.column :fac_department, :string, :limit => 64, :null => false
	t.column :fac_edudetails, :string, :limit => 128, :null => false
	t.column :fac_aboutme, :string, :limit => 128, :null => false
	t.column :gender, :string
	t.column :dob, :string
    end
  end

  def self.down
    drop_table :faculties
  end
end
