class CreateClubs < ActiveRecord::Migration
  def self.up
    create_table :clubs do |t|
	t.column :name, :string
	t.column :description, :text
	t.column :category, :string
	t.column :type, :string
	t.column :do, :string
	t.column :dont, :string
	t.column :do1, :string
	t.column :do2, :string
	t.column :dont1, :string
	t.column :dont2, :string
	t.column :caption, :text
	t.column :picture_id, :integer
    end
  end

  def self.down
    drop_table :clubs
  end
end
