class CreateCourses < ActiveRecord::Migration
	def self.up
		create_table :courses do |t|
			t.column :course, :string
			t.column :college_id, :int
		end
		execute "INSERT INTO courses (id, course, college_id) VALUES ('1', 'B.E', '1')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('2', 'B.Tech', '2')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('3', 'B.Tech', '3')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('4', 'B.E', '4')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('5', 'B.Tech', '5')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('6', 'B.E', '7')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('7', 'B.Tech', '8')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('8', 'B.E', '9')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('9', 'B.Tech', '10')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('10', 'B.E', '11')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('11', 'B.Tech', '12')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('12', 'B.Tech', '13')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('13', 'B.E', '14')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('14', 'B.Tech', '15')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('15', 'B.Tech', '16')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('16', 'B.E', '17')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('17', 'B.Tech', '18')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('18', 'B.E', '19')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('19', 'B.Tech', '20')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('20', 'B.E', '21')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('21', 'B.Tech', '22')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('22', 'B.Tech', '23')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('23', 'B.Tech', '24')"
		execute "INSERT INTO courses (id, course, college_id) VALUES ('24', 'B.Tech', '25')"
	end
	
	def self.down
		drop_table :courses
	end
end
