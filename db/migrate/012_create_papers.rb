class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
	t.column :c_name, :string
	t.column :c_year, :integer
	t.column :test_name, :string
	t.column :exam_type, :string
    end
  end

  def self.down
    drop_table :papers
  end
end
