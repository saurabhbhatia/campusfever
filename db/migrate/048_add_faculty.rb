class AddFaculty < ActiveRecord::Migration
  def self.up
	add_column :faculties, :notify_file, :boolean, :default => true
	add_column :faculties, :notify_link, :boolean, :default => false
	add_column :faculties, :notify_article, :boolean, :default => true
	add_column :faculties, :privacy_friend, :integer, :default => 1
  end

  def self.down
  end
end
