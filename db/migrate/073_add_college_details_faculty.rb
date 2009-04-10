class AddCollegeDetailsFaculty < ActiveRecord::Migration
	def self.up
		add_column :faculties, :city, :string
		add_column :faculties, :college, :string
	end
	
	def self.down

	end
end
