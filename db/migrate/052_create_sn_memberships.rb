class CreateSnMemberships < ActiveRecord::Migration
	
	def self.up
		create_table :sn_memberships do |t|
			t.column :faculty_id, :integer,  :null => false
			t.column :social_network_id, :integer,  :null => false
			t.column :created_at, :datetime
			t.column :username, :string
		end
	end
	
	def self.down
		drop_table :sn_memberships
	end
end
