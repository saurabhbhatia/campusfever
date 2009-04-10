class CreateDoubts < ActiveRecord::Migration
	
	def self.up
		create_table :doubts do |t|
			t.column :doubt, :text
			t.column :answer, :text
			t.column :question_id, :integer
			t.column :user_id, :integer
			t.column :fac_id, :integer
		end
	end
	
	def self.down
		drop_table :doubts
	end
end
