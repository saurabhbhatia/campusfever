class MainController < ApplicationController
	CURRENT_PROFILE_MODE_PRIVATE = 1
	CURRENT_PROFILE_MODE_FRIEND  = 2
	CURRENT_PROFILE_MODE_PUBLIC  = 3
	
	before_filter :prepare_data, :only => [:main, :send_file_note, :send_note]
	
	def index
		if is_logged_in1?
			redirect_to main_path(current_faculty.login)
		else
			render :layout => false
			#redirect_to :controller => 'account', :action => 'login'
		end
	end
	
	def main
		@faculty = Faculty.find(params[:id])
		#case# @current_profile_mode
			#when CURRENT_PROFILE_MODE_PUBLIC
			#@public_notes = Note.find(:all, :conditions => "is_public = true")
			#render :template => 'main/main_public'
			#when CURRENT_PROFILE_MODE_FRIEND
			#render :template => 'main/main_friend'
			#else render main/main (private)
		#end
	end
	
	def send_note
		@faculty = Faculty.find(params[:id])
		case params[:note_type][:note_type]
			when 'file'
			note = FileNote.new(params[:note])
			#note.uploaded_data = params[:note][:uploaded_data]
			when 'event'
			note = EventNote.new(params[:note])
			note[:event_time] = params[:event_time]
			#st = params[:notice]['notice_time(1i)'] << "-" << 
			#params[:notice]['notice_time(2i)'] << "-" <<
			#params[:notice]['notice_time(3i)'] << " " <<
			#params[:notice]['notice_time(4i)'] << ":" <<
			#params[:notice]['notice_time(5i)']
			#note.notice_time = Time.parse st
		end
		#common attribute
		note.sender = @faculty
		
		#handling recipients
		if note.save
			target = params[:target]
			m = /([a-z]+)_?(\d*)/.match(target)
		end
		@notes = Note.find_by_filter @faculty, @filter
		render :partial => 'note_list', :object => @notes, :locals => { :faculty => @faculty }
		#redirect_to :action => main
	end
	
	def send_file_note
		@faculty = Faculty.find(params[:id])
		note = FileNote.new(params[:note])
		note.sender = @faculty
		
		#handling recipients
		if note.save
		end
		
		responds_to_parent do
			render :update do |page|
				page.replace_html 'note_list', 
				{:partial => 'note_list', :object => @notes, :locals => { :faculty => @faculty }}
				page << "document.file_form.note_note.value='';"
				page << "document.file_form.note_uploaded_data.value='';"
			end
		end
	end
	
	def delete_note
		if Note.destroy(params[:note_id])
			render :update do |page|
				page.remove "note_#{params[:note_id]}"
			end
		end
	end
	
	def reply_note
		@original_note = Note.find params[:note_id]
		if request.post?
			@note = Note.new params[:note]
			@note.reply_to = @original_note
			@note.sender = current_faculty
			@note.is_private = true
			@note.save!
			@original_note.replies << @note
			@original_note.recipients << @note.sender
			render :partial => 'reply_item', :object => @note
		end
	end
	
	def forward_note
		@original_note = Note.find params[:note_id]
		@note = Note.new
		@note.note = @original_note.sender.login + " say:" + @original_note.note
		options_for_target_select
		
		if request.post?
			note = Note.new params[:note]
			note.sender = current_faculty
			#handling recipients
			if note.save
				target = params[:target]
				m = /([a-z]+)_?(\d*)/.match(target)
				case m[1]
					when 'public'
					note.is_public = true
					note.save!
					when 'all' # all friends
					#friends = current_user.friends
					current_faculty.friends.each do |friend|
						note.recipients << friend
					end
					when 'friend'
					id = m[2].to_i
					r = Faculty.find id
					note.recipients << r
					note.is_private = true
					note.save!
					when 'set'
					id = m[2].to_i
					g = Group.find id
					rs = g.faculties
					rs.each do |r|
						note.recipients << r
					end
					note.group = g
					when 'pgroup'
					id = m[2].to_i
					g = PrivateGroup.find id
					rs = g.members
					rs.each do |r|
						note.recipients << r
					end
					note.private_group = g
				end
			end
			redirect_to main_path(current_faculty)
		end
	end
	
private

	def prepare_data
		#get user, filter condition, and note list
		@current_profile_mode = CURRENT_PROFILE_MODE_PUBLIC
		if params[:faculty]
			@faculty = Faculty.find(params[:id])
			#@faculty = Faculty.find_by_login params[:faculty]
			if @faculty  # there's such an user
				if is_logged_in1?
					if current_faculty.login == params[:faculty]                      # is currently logged in user
						@current_profile_mode = CURRENT_PROFILE_MODE_PRIVATE
					elsif current_faculty.is_friends_with? @faculty                # friend with current user
						@current_profile_mode = CURRENT_PROFILE_MODE_FRIEND
					end
				end
			else # no such user
				#TODO goto 404 file
			end
		else
			@current_profile_mode = CURRENT_PROFILE_MODE_PRIVATE
			@faculty = logged_in_faculty
		end
		#@groups = @faculty.owned_groups
		#@private_groups = @faculty.private_groups
		#@private_groups = @faculty.owned_private_groups + @faculty.private_groups
		#@sns = @faculty.sn_memberships
		#@ims = @faculty.im_memberships
			
		options_for_target_select
		options_for_filter_select
			
		@referrals_count = Note.count(["sender_id = ? and `type`='ReferralNote'", @faculty])
		@leads_count = Note.count(["sender_id = ? and `type`='LeadNote'", @faculty])
		@opportunities_count = Note.count(
		["sender_id = ? and `type`='Note' or `type`='LinkNote' or `type`='FileNote' or `type`='EventNote'", @faculty])
		@dangers_count = Note.count(["sender_id = ? and `type`='DangerNote'", @faculty])
	end

	def options_for_target_select
		#prepare for target select box
		@option_str = '<option value="public">the public</option>' + "\n" +
		'<option value="all" selected="selected">all my friends</option>' + "\n"
		if @groups && !(@groups.empty?)
			@option_str << '<optgroup label="set">' + "\n"
			@groups.each do |group|
				@option_str << '<option value="set_' + group.id.to_s + '">' + group.name + '</option>' + "\n" 
			end
			@option_str << '</optgroup>' + "\n"
		end
		
		if @private_groups && !(@private_groups.empty?)
			@option_str << '<optgroup label="private group">' + "\n"
			@private_groups.each do |group|
				@option_str << '<option value="pgroup_' + group.id.to_s + '">' + group.name + '</option>' + "\n" 
			end
			@option_str << '</optgroup>' + "\n"
		end
		
		if @friends && !(@friends.empty?)
			@option_str << '<optgroup label="private note">' + "\n"
			@friends.each do |friend|
				@option_str << '<option value="friend_' + friend.id.to_s + '">' + 
				 friend.fac_displayname + ' ' + friend.fac_title + '</option>' + "\n" 
			end
			@option_str << '</optgroup>' + "\n"
		end
	end
	
	def options_for_filter_select
		selected_str = {"all" => "", 
		"notes" => "",
		"replies" => "",
		"private" => "",
		"nonpublic" => "",
		"sent" => "",
		"messages" => "",
		"links" => "",
		"files" => "",
		"events" => ""}
		
		selected_str[@filter] = ' selected="selected"'
		#prepare for filter select box
		@filter_option_str =  '<option value="all"'+selected_str["all"]+'>all notes &amp; replies</option>' + "\n" +
		'<option value="notes"'+selected_str["notes"]+'>notes</option>' + "\n" +
		'<option value="replies"'+selected_str["replies"]+'>replies</option>' + "\n" +
		'<option value="private"'+selected_str["private"]+'>private notes</option>' + "\n" +
		'<option value="nonpublic"'+selected_str["nonpublic"]+'>non-public notes</option>' + "\n" +
		'<option value="sent"'+selected_str["sent"]+'>sent by me</option>' + "\n" +
		'<optgroup label="note type">' + "\n" +
		'<option value="messages"'+selected_str["messages"]+'>messages</option>' + "\n" +
		'<option value="links"'+selected_str["links"]+'>links</option>' + "\n" +
		'<option value="files"'+selected_str["files"]+'>files</option>' + "\n" +
		'<option value="events"'+selected_str["events"]+'>events</option>' + "\n"
		'</optgroup>'
		
		if (@current_profile_mode == CURRENT_PROFILE_MODE_PRIVATE) && @groups && !(@groups.empty?)
			@filter_option_str << '<optgroup label="set">' + "\n"
			@groups.each do |group|
				@filter_option_str << '<option value="set_' + group.id.to_s + '">' + group.name + '</option>' + "\n" 
			end
			@filter_option_str << '</optgroup>' + "\n"
		end
		if (@current_profile_mode == CURRENT_PROFILE_MODE_PRIVATE) && @private_groups && !(@private_groups.empty?)
			@filter_option_str << '<optgroup label="set">' + "\n"
			@private_groups.each do |group|
				@filter_option_str << '<option value="pgroup_' + group.id.to_s + '">' + group.name + '</option>' + "\n" 
			end
			@filter_option_str << '</optgroup>' + "\n"
		end
	end
end
