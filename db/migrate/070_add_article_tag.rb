class AddArticleTag < ActiveRecord::Migration
	
	def self.up
		add_column :articles, :tags, :text
	end
	
	def self.down
	end
end
