class AddIntroductionPaper < ActiveRecord::Migration
	def self.up
		add_column :papers, :introduction, :text, :limit => 10000
	end
	
	def self.down

	end
end
