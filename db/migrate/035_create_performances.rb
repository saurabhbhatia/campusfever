class CreatePerformances < ActiveRecord::Migration
  def self.up
    create_table :performances do |t|
	t.column :user_id, :integer
	t.column :paper_id, :integer
	t.column :performance, :string
	t.column :right, :integer
	t.column :wrong, :integer
    end
  end

  def self.down
    drop_table :performances
  end
end
