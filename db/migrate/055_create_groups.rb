class CreateGroups < ActiveRecord::Migration
	
	def self.up
		create_table :groups do |t|
			t.column :name, :string, :default => "", :null => false
			t.column :owner_id, :integer 
			t.column :created_at, :datetime
		end
	end
	
	def self.down
		drop_table :groups
	end
end
