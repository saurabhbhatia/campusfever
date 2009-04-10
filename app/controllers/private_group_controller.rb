class PrivateGroupController < ApplicationController
	
	def index
		@private_groups = current_faculty.owned_private_groups + current_faculty.private_groups
	end
	
	def new
		if request.post?
			private_group = PrivateGroup.new(params[:private_group])
			private_group.owner = current_faculty
			private_group.save!
			redirect_to private_group_path
		end
	end
	
	def edit
		@private_group = PrivateGroup.find(params[:id])
		if request.post?
			private_group = PrivateGroup.update_attributes(params[:private_group])
			redirect_to private_group_path
		end
	end
	
	def search
		if request.post?
			@private_groups = PrivateGroup.find(:all)
		end
	end
	
	def view
		@private_group = PrivateGroup.find params[:id]
		@members = @private_group.members
		@is_owner = (@private_group.owner.id == current_faculty.id)
	end
	
	def join
		@private_group = PrivateGroup.find params[:id]
		membership = PrivateGroupMembership.new
		membership.faculty = current_faculty
		membership.private_group = @private_group
		membership.requested_at = Time.now
		membership.save!
		redirect_to private_group_path
	end
	
	def approve
		@private_group = PrivateGroup.find params[:id]
		member = Faculty.find params[:faculty_id]
		membership = @private_group.membership member
		membership.approved_at = Time.now
		membership.save!
		
		redirect_to private_group_path(:action => 'view', :id => @private_group)
	end
	
	def search_members
		@private_group = PrivateGroup.find params[:id]
		if request.post?
			@candidates = Faculty.find(:all)
		end
	end
	
	def invite
		@private_group = PrivateGroup.find params[:id]
		candidate = Faculty.find params[:candidate_id]
		membership = PrivateGroupMembership.new
		membership.faculty = candidate
		membership.private_group = @private_group
		membership.invited_at = Time.now
		membership.save!
		
		redirect_to private_group_path(:action => 'view', :id => @private_group)
	end
	
	def accept
		@private_group = PrivateGroup.find params[:id]
		membership = @private_group.membership current_faculty
		membership.accepted_at = Time.now
		membership.save!
		
		redirect_to private_group_path(:action => 'view', :id => @private_group)
	end
end
