class Userid < ActiveRecord::Migration
  def self.up
	add_column :clubs, :user_id, :integer
  end

  def self.down
  end
end
