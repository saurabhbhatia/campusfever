class Paper < ActiveRecord::Base
	validates_presence_of :test_name
	validates_uniqueness_of :test_name
	
	has_many :exams
	has_and_belongs_to_many :exams
	has_and_belongs_to_many :performances
	has_and_belongs_to_many :users
end
