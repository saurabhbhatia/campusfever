class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
	t.column :type, :string
	t.column :size, :integer
	t.column :content_type, :string
	t.column :filename, :string
	t.column :is_private, :boolean, :default => false
	t.column :is_public, :boolean, :default => false
	t.column :sender_id, :integer, :null => false
	t.column :reply_to, :integer
	t.column :group_id, :integer
	t.column :private_group_id, :integer
	t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :notes
  end
end
