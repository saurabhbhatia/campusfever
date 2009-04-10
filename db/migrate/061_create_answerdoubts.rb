class CreateAnswerdoubts < ActiveRecord::Migration
	
	def self.up
		create_table :answerdoubts do |t|
			t.column :answer, :text
			t.column :doubt_id, :integer
		end
	end
	
	def self.down
		drop_table :answerdoubts
	end
end
