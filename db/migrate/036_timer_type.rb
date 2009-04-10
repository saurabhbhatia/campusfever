class TimerType < ActiveRecord::Migration
  def self.up
	add_column :papers, :exam_value, :string
  end

  def self.down
  end
end
