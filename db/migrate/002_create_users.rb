class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
	t.column :firstname, :string, :limit => 64, :null => false
	t.column :lastname, :string, :limit => 64, :null => false
	t.column :email, :string, :limit => 128, :null => false
	t.column :hashed_password, :string, :limit => 64
	t.column :activate, :boolean, :default => true, :null => false
	t.column :pass_month_year, :date
	t.column :branch, :integer, :null => false
	t.column :semester, :string, :null => false
	t.column :state, :integer, :null => false
	t.column :city, :integer, :null => false
	t.column :college, :integer, :null => false
	t.column :course, :integer, :null => false
	t.column :created_at, :datetime
	t.column :updated_at, :datetime
	t.column :last_login_at, :datetime
	t.column :visibility, :integer
	t.column :status, :integer
	t.column :verifyflag, :boolean
	t.column :blockflag, :boolean
    end
  end

  def self.down
    drop_table :users
  end
end
