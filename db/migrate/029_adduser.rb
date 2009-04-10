class Adduser < ActiveRecord::Migration
  def self.up
	add_column :papers, :admin_id, :integer
  end

  def self.down
  end
end
