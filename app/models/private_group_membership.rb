class PrivateGroupMembership < ActiveRecord::Base
	belongs_to :faculty
	belongs_to :private_group
end
