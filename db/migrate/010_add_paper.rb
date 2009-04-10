class AddPaper < ActiveRecord::Migration
  def self.up
	#add_column :exams, :signup_id, :integer
	add_column :exams, :published, :boolean, :default => false
	add_column :exams, :created_at, :datetime
	add_column :exams, :published_at, :datetime
  end

  def self.down
  end
end
