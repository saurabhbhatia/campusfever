class PrivateGroup < ActiveRecord::Base

	has_many :private_group_memberships, :dependent => :destroy
	has_many :members, :through => :private_group_memberships, :source => :faculty
	belongs_to :owner, :class_name => 'Faculty', :foreign_key => 'owner_id'
	
	def is_author?(faculty)
		owner_id == faculty.id
	end
	
	def is_pending_accept?(faculty)
		ms = membership(faculty)
		(!ms.nil?) and (ms.invited_at != nil) and (ms.accepted_at == nil)
	end
	
	def is_pending_request?(faculty)
		ms = membership(faculty) 
		(!ms.nil?) and (ms.requested_at != nil) and (ms.approved_at == nil)
	end
	
	def is_member?(faculty)
		members.include?(faculty)
	end
	
	def membership(faculty)
		PrivateGroupMembership.find(:first, :conditions => ['private_group_id = ? AND faculty_id = ?', self.id, faculty.id])
	end

end
