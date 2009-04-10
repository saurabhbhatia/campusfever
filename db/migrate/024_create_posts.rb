class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
	t.column :message, :string
	t.column :thought, :string 
	t.column :forumid, :integer
    end
  end

  def self.down
    drop_table :posts
  end
end
