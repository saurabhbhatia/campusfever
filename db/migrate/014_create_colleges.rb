class CreateColleges < ActiveRecord::Migration
	def self.up
		create_table :colleges do |t|
			t.column :college, :string
			t.column :city_id, :int
		end
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('1', 'Avanthi Institute of Engineering and Technology, Hyderabad', '1')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('2', 'IIT Guwahati, Guwahati', '22')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('3', 'Maulana Azad College of Engineering & Technology, Anishabad, Patna', '4')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('4', 'National Institute of Technology, Raipur', '5')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('5', 'Chandigarh College of Engineering & Technology, Chandigarh', '8')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('6', 'Delhi College of Engineering, Delhi', '1')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('7', 'Government Engineering College, GIDC Estate, Gandhinagar', '7')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('8', 'Goa College of Engineering, North Goa, Goa', '6')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('9', 'National Institute of Technology, Hamirpur,Shimla', '9')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('10', 'National Institute of Technology, Srinagar', '10')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('11', 'Birla Institute of Technology, Mesra, Ranchi', '11')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('12', 'BMS Institute of Technology, Bangalore', '12')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('13', 'Indian Institute of Information Technology and Management-Kerala (IIITM-K)', '13')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('14', 'JEC, Jabalpur', '14')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('15', 'Maulana Azad National Institute of Technology, Bhopal', '14')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('16', 'Sardar Patel College of Engineering, Andheri, Mumbai', '15')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('17', 'Shillong Engineering & Management College, GS Road, Shillong', '17')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('18', 'Kalinga Institute of Industrial Technology, Khurda, Bhubaneswar', '19')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('19', 'Pondicherry Engineering College, Pillaichavady, Pondicherry', '1')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('20', 'Madras Institute of Technology, Chennai', '23')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('21', 'Tripura Engineering College, Tripura West, Agartala', '24')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('22', 'Dehradun Institute of Technology, Dehradun', '26')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('23', 'College of Engineering Sciences & Technology, Lucknow', '25')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('24', 'Institute of Engineering & Management, Sector V, Kolkata', '27')"
		execute "INSERT INTO colleges (id, college, city_id) VALUES ('25', 'Malviya National Institute of Technology', '21')"
	end
	
	def self.down
		drop_table :colleges
	end
end
