class ExamsPapers < ActiveRecord::Migration
  def self.up
    create_table :exams_papers, :id => false do |t|
	t.column :exam_id, :int
	t.column :paper_id, :int
    end
  end

  def self.down
  end
end
