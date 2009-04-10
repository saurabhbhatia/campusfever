class AddExamTimer < ActiveRecord::Migration
	def self.up
		add_column :papers, :timer, :time
	end
	
	def self.down
	end
end
