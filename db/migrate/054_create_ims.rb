class CreateIms < ActiveRecord::Migration
	
	def self.up
		create_table :ims do |t|
			t.column :name, :string, :default => "", :null => false
			t.column :code, :string, :limit => 50
		end
	end
	
	def self.down
		drop_table :ims
	end
end
