class CreateSocialNetworks < ActiveRecord::Migration
	def self.up
		create_table :social_networks do |t|
			t.column :name, :string, :default => "", :null => false
			t.column :code, :string, :limit => 50
		end
	end
	
	def self.down
		drop_table :social_networks
	end
end
