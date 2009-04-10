class SocialNetwork < ActiveRecord::Base
	has_many :sn_memberships
	has_many :faculties, :through => :sn_memberships 
end
