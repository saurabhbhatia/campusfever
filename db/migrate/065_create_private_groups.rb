class CreatePrivateGroups < ActiveRecord::Migration
	
	def self.up
		create_table :private_groups do |t|
			t.column "name", :string, :default => "", :null => false
			t.column "description", :text
			t.column "owner_id", :integer
			t.column "created_at", :datetime
		end
	end
	
	def self.down
		drop_table :private_groups
	end
end
