class CreateAnswers < ActiveRecord::Migration
	def self.up
		create_table :answers do |t|
			t.column :answer, :text
			t.column :question_id, :integer
			t.column :user_id, :integer
			t.column :fac_id, :integer
		end
	end
	
	def self.down
		drop_table :answers
	end
end
