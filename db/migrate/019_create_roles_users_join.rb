class CreateRolesUsersJoin < ActiveRecord::Migration
  def self.up
	create_table :roles_users, :id => false do |t|
		t.column :role_id, :integer, :null => false
		t.column :user_id, :integer, :null => false
	end
	admin_user = User.create(:firstname => 'Kaustubh Verma',
	:lastname => 'Site Administrator',
	:email => 'kaustubh.verma@gmail.com',
        :password => 'kaustubhverma12345', :password_confirmation => 'kaustubhverma12345')
	admin_role = Role.find_by_name('Administrator')
	admin_user.roles << admin_role
  end

  def self.down
	drop_table :roles_users
	User.find_by_firstname('Admin').destroy
  end
end
