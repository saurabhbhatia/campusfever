class CreateBranches < ActiveRecord::Migration
	def self.up
		create_table :branches do |t|
			t.column :branch, :string
			t.column :course_id, :int
		end
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('1', 'Computer Science', '1')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('2', 'Computer Science', '2')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('3', 'Computer Science', '3')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('4', 'Computer Science', '4')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('5', 'Computer Science', '5')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('6', 'Computer Science', '6')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('7', 'Computer Science', '7')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('8', 'Computer Science', '8')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('9', 'Computer Science', '9')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('10', 'Computer Science', '10')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('11', 'Computer Science', '11')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('12', 'Computer Science', '12')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('13', 'Computer Science', '13')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('14', 'Computer Science', '14')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('15', 'Computer Science', '15')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('16', 'Computer Science', '16')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('17', 'Computer Science', '17')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('18', 'Computer Science', '18')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('19', 'Computer Science', '19')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('20', 'Computer Science', '20')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('21', 'Computer Science', '21')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('22', 'Computer Science', '22')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('23', 'Computer Science', '23')"
		execute "INSERT INTO branches (id, branch, course_id) VALUES ('24', 'Computer Science', '24')"
	end
	
	def self.down
		drop_table :branches
	end
end
