class AddFacultyAdminValues < ActiveRecord::Migration
	def self.up
		add_column :faculties, :state_id, :integer
		add_column :faculties, :city_id, :integer
		add_column :faculties, :college_id, :integer
		remove_column :faculties, :city
		remove_column :faculties, :college
	end
	
	def self.down
	end
end
