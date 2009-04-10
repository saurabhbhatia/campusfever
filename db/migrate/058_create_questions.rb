class CreateQuestions < ActiveRecord::Migration
	def self.up
		create_table :questions do |t|
			t.column :question, :string
			t.column :user_id, :integer
			t.column :fac_id, :integer
		end
	end
	
	def self.down
		drop_table :questions
	end
end
