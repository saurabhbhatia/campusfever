class Exam < ActiveRecord::Base
	has_and_belongs_to_many :papers
end
