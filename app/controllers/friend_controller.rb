class FriendController < ApplicationController
	
	def index
		@friends = current_faculty.friends
		@faculty = current_faculty
	end
	
	def request_friend
		faculty = Faculty.find params[:faculty_id]
		current_faculty.request_friendship_with faculty
		FriendshipMailer.deliver_request_friend(current_faculty, faculty)
		redirect_to main_path(faculty.login)
	end
	
	# withraw friend request
	def cancel_friend
		faculty = Faculty.find params[:faculty_id]
		#TODO do some check first?
		current_faculty.delete_friendship_with faculty
		redirect_to main_path(faculty.login)
	end
	
	def accept_friend
		faculty = Faculty.find params[:faculty_id]
		#TODO do some check first?
		current_faculty.become_friends_with faculty
		FriendshipMailer.deliver_request_friend(current_faculty, faculty)
		redirect_to main_path(faculty.login)
	end
	
	def unfriend
		faculty = Faculty.find params[:faculty_id]
		current_faculty.friendship(faculty).update_attributes(:accepted_at => nil); # back to pending status
		redirect_to main_path(faculty.login)
	end
	
	# request to become a friend with a user. If that user is your fan then he will become your frind
	def remote_request
		faculty = faculty.find params[:faculty_id]
		
		is_friend = false
		unless current_faculty.pending_friends_for_me.include? faculty # if this user is not your fan
		current_faculty.request_friendship_with faculty              # then just request
		else
			current_faculty.become_friends_with faculty                  # otherwise just become friend
			is_friend = true
		end
		@friends = current_faculty.friends
		render :update do |page|
			page.replace_html "faculty_#{faculty.id}", :partial => 'added_friend', :object => faculty
			page.replace_html 'friend_list', 
			{:partial => 'friend_controls', :object => @friends, 
			:locals => { :faculty => faculty, :is_friend => is_friend }}
		end
	end
	
	def remote_unfriend
		faculty = Faculty.find params[:faculty_id]
		current_faculty.delete_friendship_with faculty
		#TODO delete all messages of this friend
		
		render :update do |page|
			page.remove "friend_#{params[:faculty_id]}"
		end
	end
	
	def search
		@faculties = Faculty.find :all, :conditions => ["id <> ?", current_faculty]
		render :partial => 'search_result', :object => @faculties
	end
	
	private
end
