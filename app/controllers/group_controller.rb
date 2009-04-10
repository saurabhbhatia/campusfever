class GroupController < ApplicationController
	def add
		@friends = current_faculty.friends
		@groups = current_faculty.groups
		
		#prepare for checkboxs
		@checkbox_statuses = Hash.new
		@friends.each do |friend|
			@checkbox_statuses[friend.id] = false
		end
		
		if request.post?
			@group = Group.new params[:group]
			@group.owner = current_faculty
			begin
			@group.save!
			rescue ActiveRecord::RecordInvalid
			flash[:error] = "Name can't be null"
			render(:template => 'group/groups')
			return
		end
		
		member_indexes = params["member_indexes"]
		unless member_indexes.nil?
		member_indexes.each do |member_id|
			member = Faculty.find member_id.to_i
			@group.faculties << member
		end
		#@group.save!
	end
	redirect_to group_add_path and return
end
    render :template => 'group/groups'
  end

	def edit
		@friends = current_faculty.friends
		@groups = current_faculty.groups
		@group = Group.find params[:group_id]
		
		#prepare for checkboxs
		@checkbox_statuses = Hash.new
		@friends.each do |friend|
			@checkbox_statuses[friend.id] = false
		end
		
		members = @group.faculties
		members.each do |member|
			@checkbox_statuses[member.id] = true
		end
		
		if request.post?
			@group.update_attributes params[:group]
			#@group.users.delete_all
			@group.group_memberships.delete_all
			@group.users << current_faculty
			member_indexes = params["member_indexes"]
			unless member_indexes.nil?
			member_indexes.each do |member_id|
				member = Faculty.find member_id.to_i
				@group.faculties << member
			end
		end
		redirect_to group_add_path and return
		#@group.save!
	end
	render :template => 'group/groups'
end

	def delete
		group = Group.find params[:group_id]
		#group.users.delete current_user
		group.destroy
		redirect_to group_add_path
	end
end
