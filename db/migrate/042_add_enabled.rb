class AddEnabled < ActiveRecord::Migration
  def self.up
	add_column :faculties, :enabled, :boolean, :default => true, :null => false
  end

  def self.down
  end
end

