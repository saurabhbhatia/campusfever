class Course < ActiveRecord::Base
    belongs_to :college
    has_many :branches
    
    belongs_to :faculty

    #validate_uniqueness_of :course
end
