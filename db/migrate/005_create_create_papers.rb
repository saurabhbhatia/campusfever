class CreateCreatePapers < ActiveRecord::Migration
  def self.up
    create_table :create_papers do |t|
    end
  end

  def self.down
    drop_table :create_papers
  end
end
