class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
	    t.column :search, :string
    end
  end

  def self.down
    drop_table :searches
  end
end
