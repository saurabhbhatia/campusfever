class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
    end
  end

  def self.down
    drop_table :exams
  end
end
