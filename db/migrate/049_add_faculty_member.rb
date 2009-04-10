class AddFacultyMember < ActiveRecord::Migration
  def self.up
	add_column :faculties, :remember_token, :string
	add_column :faculties, :remember_token_expires_at, :datetime
	add_column :faculties, :default_target, :string,   :limit => 20
	add_column :faculties, :default_filter,  :string,   :limit => 20
	add_column :faculties, :notify_request, :boolean, :default => true
	add_column :faculties, :notify_private, :boolean, :default => true
	add_column :faculties, :notify_notice, :boolean, :default => true
	add_column :faculties, :notify_plain, :boolean, :default => false
	add_column :faculties, :notify_reply, :boolean, :default => true
	add_column :faculties, :privacy_email, :integer, :default => 2
	add_column :faculties, :privacy_profile, :integer, :default => 2
	add_column :faculties, :privacy_location, :integer, :default => 2
	add_column :faculties, :privacy_country, :integer, :default => 2
	add_column :faculties, :privacy_age, :integer, :default => 2
	add_column :faculties, :privacy_gender, :integer, :default => 2
	add_column :faculties, :privacy_sn, :integer, :default => 2
	add_column :faculties, :privacy_im, :integer, :default => 2
	add_column :faculties, :privacy_web, :integer, :default => 2
  end

  def self.down
  end
end
