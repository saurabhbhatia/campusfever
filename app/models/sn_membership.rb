class SnMembership < ActiveRecord::Base
	belongs_to :faculty
	belongs_to :social_network
end
