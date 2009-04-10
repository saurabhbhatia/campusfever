class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
	t.column :subject, :string
	t.column :message, :string
	t.column :clubid, :integer
	t.column :clubname, :string
	t.column :created_at, :datetime
	t.column :picture_id, :integer
    end
  end

  def self.down
    drop_table :forums
  end
end
