class ImMembership < ActiveRecord::Base
	belongs_to :faculty
	belongs_to :im
end
