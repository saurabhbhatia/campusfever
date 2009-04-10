class CreatePrivateGroupMemberships < ActiveRecord::Migration
	def self.up
		create_table :private_group_memberships do |t|
			t.column "faculty_id", :integer, :null => false
			t.column "private_group_id", :integer, :null => false
			t.column "requested_at", :datetime
			t.column "approved_at", :datetime
			t.column "invited_at", :datetime
			t.column "accepted_at", :datetime
			t.column "created_at", :datetime
		end
	end
	
	def self.down
		drop_table :private_group_memberships
	end
end
