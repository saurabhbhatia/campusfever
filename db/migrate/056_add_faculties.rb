class AddFaculties < ActiveRecord::Migration
	
	def self.up
		add_column :faculties, :height, :integer
		add_column :faculties, :width, :integer
		add_column :faculties, :content_type, :string
		add_column :faculties, :size, :integer
		add_column :faculties, :filename, :string
	end
	
	def self.down
	end
end
