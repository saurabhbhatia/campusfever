class Friendship < ActiveRecord::Base

	has_many :faculties
	belongs_to :friendshipped_by_me, :foreign_key => "faculty_id", :class_name => "Faculty"
	belongs_to :friendshipped_for_me, :foreign_key => "friend_id", :class_name => "Faculty"

end
