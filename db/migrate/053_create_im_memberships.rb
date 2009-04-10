class CreateImMemberships < ActiveRecord::Migration
	def self.up
		create_table :im_memberships do |t|
			t.column :faculty_id, :integer,  :null => false
			t.column :im_id, :integer,  :null => false
			t.column :created_at, :datetime
			t.column :username, :string
		end
	end
	
	def self.down
		drop_table :im_memberships
	end
end
