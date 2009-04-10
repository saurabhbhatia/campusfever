class SettingsController < ApplicationController
	before_filter :processing, :except => [:add_sn, :add_im, :add_web, :delete_sn, :delete_im, :delete_web]
	
	def preferences
		unless request.post?
		@groups = @faculty.groups
		@filter = @faculty.default_filter
		options_for_target_select
		options_for_filter_select
	end
end

	#TODO do we need this method?
	def photo
		@faculty = current_faculty
		if request.post?
			@faculty.uploaded_data = params[:faculty][:uploaded_data]
			if @faculty.save
				flash[:notice] = "Profile has been saved."
			else
				flash[:error] = "Can't save."
			end
			redirect_to :back
		end
	end
	
	def other_profiles
		@sns = @faculty.sn_memberships;
		@ims = @faculty.im_memberships;
		@webs = @faculty.websites;
	end
	
	def add_sn
		@faculty = current_faculty
		if request.post?
			sn_membership = SnMembership.new params[:sn_membership]
			@faculty.sn_memberships << sn_membership
			flash[:notice] = "Social network has been added."
			redirect_to settings_path('other_profiles')
		end
	end
	
	def add_im
		@faculty = current_faculty
		if request.post?
			im_membership = ImMembership.new params[:im_membership]
			@faculty.im_memberships << im_membership
			flash[:notice] = "IM has been added."
			redirect_to settings_path('other_profiles')
		end
	end
	
	def add_web
		@faculty = current_faculty
		if request.post?
			website = Website.new params[:web]
			@faculty.websites << website
			flash[:notice] = "Website has been added."
			redirect_to settings_path('other_profiles')
		end
	end
	
	def delete_sn
		@faculty = current_faculty
		snm = SnMembership.find params[:id]
		snm.destroy
		redirect_to settings_path('other_profiles')
	end
	
	def delete_im
		@faculty = current_faculty
		imm = ImMembership.find params[:id]
		imm.destroy
		redirect_to settings_path('other_profiles')
	end
	
	def delete_web
		@faculty = current_faculty
		web = Website.find params[:id]
		@faculty.websites.delete web
		redirect_to settings_path('other_profiles')
	end
	
	private
	
	def processing
		@faculty = current_faculty
		if request.post?
			if @faculty.update_attributes params[:faculty]
			flash[:notice] = "Profile has been saved."
		else
			flash[:error] = "Can't save."
		end
		redirect_to :back
	end
end

	def options_for_target_select
		# prepare for target select box
		@option_str = '<option value="public">the public</option>' + "\n" +
		'<option value="all" selected="selected">all my friends</option>' + "\n"
		if @groups && !(@groups.empty?)
			@option_str << '<optgroup label="set">' + "\n"
			@groups.each do |group|
				this_option = '<option value="set_' + group.id.to_s + '">' + group.name + '</option>' + "\n"
				if @filter[0,4] = 'set_'
					id = @filter.sub('set_','').to_i
					if (group.id == id)
						this_option = '<option value="set_' + group.id.to_s + '" selected="selected">' + group.name + '</option>' + "\n"
				end
				end
			@option_str << this_option
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
		"files" => ""}
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
		'<option value="events"'+selected_str["events"]+'>events</option>' + "\n" +
		'</optgroup>'
		if @groups && !(@groups.empty?)
			@filter_option_str << '<optgroup label="set">' + "\n"
			@groups.each do |group|
				this_option = '<option value="set_' + group.id.to_s + '">' + group.name + '</option>' + "\n"
				if @filter[0,4] = 'set_'
					id = @filter.sub('set_','').to_i
					if (group.id == id)
						this_option = '<option value="set_' + group.id.to_s + '" selected="selected">' + group.name + '</option>' + "\n"
					end
				end
				@filter_option_str << this_option
			end
			@filter_option_str << '</optgroup>' + "\n"
		end
	end
end
