class AddFacultiesBranch < ActiveRecord::Migration
	def self.up
		create_table :mybranches, :id => false do |t|
			t.column :faculty_id, :integer
			t.column :branch_id, :integer
		end
	end
	
	def self.down

	end
end
