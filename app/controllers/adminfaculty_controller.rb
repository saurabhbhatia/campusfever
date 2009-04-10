class AdminfacultyController < ApplicationController
	
	def login
	end
	
	def authenticate
		self.logged_in_faculty = Faculty.authenticate(params[:faculty][:email], params[:faculty][:password])
		if is_logged_in1?
			redirect_to :controller => 'faculties', :action => 'welcome', :id => logged_in_faculty
		else
			flash[:notice] = "I'm sorry; either your username or password was incorrect."
			redirect_to :action => 'login'
		end
	end
	
	def logout
		if request.post?
			reset_session
			flash[:notice] = "You have been logged out."
		end
		redirect_to index_url
	end
end
