class Addimage < ActiveRecord::Migration
  def self.up
	add_column :exams, :picture_id, :integer
  end

  def self.down
  end
end
