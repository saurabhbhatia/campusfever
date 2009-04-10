class Im < ActiveRecord::Base
	has_many :im_memberships
	has_many :faculties, :through => :im_memberships 
end
