class AddExams < ActiveRecord::Migration
  def self.up
	add_column :exams, :question, :string
	add_column :exams, :option_a, :string
	add_column :exams, :option_b, :string
	add_column :exams, :option_c, :string
	add_column :exams, :option_d, :string
	add_column :exams, :answer, :string
  end

  def self.down
  end
end
