class AddInstructions < ActiveRecord::Migration
  def self.up
	add_column :exams, :instructions, :string
  end

  def self.down
  end
end
