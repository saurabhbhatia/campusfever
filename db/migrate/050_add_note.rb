class AddNote < ActiveRecord::Migration
	def self.up
		add_column :notes, :note, :text, :null => false
		add_column :notes, :link, :string
		add_column :notes, :event_title, :string
		add_column :notes, :event_location, :string
		add_column :notes, :event_time, :datetime
	end
	
	def self.down
	end
end
