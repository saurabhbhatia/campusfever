class CreateStates < ActiveRecord::Migration
	def self.up
		create_table :states do |t|
			t.column :state, :string
		end
		[ 'Andhra Pradesh', 
		'Arunachal Pradesh', 
		'Assam', 
		'Bihar', 
		'Chhattisgarh', 
		'Goa',
		'Gujarat',
		'Haryana',
		'Himachal Pradesh',
		'Jammu and Kashmir',
		'Jharkhand',
		'Karnataka',
		'Kerala',
		'Madhya Pradesh',
		'Maharashtra',
		'Manipur',
		'Meghalaya',
		'Mizoram',
		'Nagaland',
		'Orissa',
		'Punjab',
		'Rajasthan',
		'Sikkim',
		'Tamil Nadu',
		'Tripura',
		'Uttar Pradesh',
		'Uttarakhand',
		'West Bengal'].map{ |state| State.create(:state => state) }
	end
	
	def self.down
		drop_table :states
	end
end
