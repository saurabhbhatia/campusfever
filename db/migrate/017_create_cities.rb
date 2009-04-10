class CreateCities < ActiveRecord::Migration
	def self.up
		create_table :cities do |t|
			t.column :city, :string
			t.column :state_id, :integer
		end
		execute "INSERT INTO cities (id, city, state_id) VALUES ('1', 'Hyderabad', '1')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('2', 'Itanager', '2')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('3', 'Dispur', '3')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('4', 'Patna', '4')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('5', 'Raipur', '5')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('6', 'Panaji', '6')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('7', 'Gandhinagar', '7')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('8', 'Chandigarh', '8')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('9', 'Shimla', '9')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('10', 'Srinagar', '10')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('11', 'Ranchi', '11')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('12', 'Bangalore', '12')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('13', 'Trivandrum', '13')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('14', 'Bhopal', '14')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('15', 'Bombay', '15')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('16', 'Imphal', '16')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('17', 'Shillong', '17')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('18', 'Kohima', '19')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('19', 'Bhubaneswar', '20')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('20', 'Chandigarh', '21')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('21', 'Jaipur', '22')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('22', 'Gangtok', '23')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('23', 'Chennai', '24')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('24', 'Agartala', '25')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('25', 'Lucknow', '26')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('26', 'Dehra Dun', '27')"
		execute "INSERT INTO cities (id, city, state_id) VALUES ('27', 'Calcutta', '28')"
	end
	
	def self.down
		drop_table :cities
	end
end
