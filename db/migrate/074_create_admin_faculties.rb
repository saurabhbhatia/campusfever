class CreateAdminFaculties < ActiveRecord::Migration
  def self.up
    create_table :admin_faculties do |t|
    end
  end

  def self.down
    drop_table :admin_faculties
  end
end
