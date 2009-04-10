class AddOptione < ActiveRecord::Migration
  def self.up
	add_column :exams, :option_e, :string
  end

  def self.down
  end
end
