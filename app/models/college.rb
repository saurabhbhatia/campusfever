class College < ActiveRecord::Base
    belongs_to :city
    has_many :courses
end
