class Adduserid < ActiveRecord::Migration
  def self.up
	add_column :rates, :user_id, :integer
  end

  def self.down
  end
end
