class GroupMembership < ActiveRecord::Base
	belongs_to :faculty
	belongs_to :group
end
