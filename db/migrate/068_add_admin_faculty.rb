class AddAdminFaculty < ActiveRecord::Migration
	def self.up
		add_column :faculties, :admincollege_id, :integer
		add_column :faculties, :admin_flag, :integer
		add_column :faculties, :profiles_sanction, :integer
		add_column :faculties, :profiles_used, :integer
	end
	
	def self.down
	end
end
