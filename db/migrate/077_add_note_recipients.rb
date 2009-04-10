class AddNoteRecipients < ActiveRecord::Migration
	
	def self.up
		add_column :note_recipients, :branch_id, :integer
		remove_column :note_recipients, :created_at
		remove_column :note_recipients, :hidden
	end
	
	def self.down
	end
end
