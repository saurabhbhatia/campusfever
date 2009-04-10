class CreateNoteRecipients < ActiveRecord::Migration
  def self.up
    create_table :note_recipients, :id => false do |t|
	t.column :faculty_id, :integer, :null => false
	t.column :note_id, :integer, :null => false
	t.column :created_at, :datetime
	t.column :hidden, :boolean
    end
  end

  def self.down
    drop_table :note_recipients
  end
end
