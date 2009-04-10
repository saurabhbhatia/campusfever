class AccountController < ApplicationController

def login
end

def authenticate
	self.logged_in_user = User.authenticate(params[:user][:email], params[:user][:password])
	if is_logged_in?
		#redirect_to :controller => 'users', :action => 'show'
		redirect_to :controller => 'pages', :action => 'new', :id => logged_in_user
	else
		flash[:error] = "I'm sorry; either your username or password was incorrect."
		redirect_to :action => 'login'
	end
end

def logout
	if request.post?
	reset_session
	flash[:notice] = "You have been logged out."
	end
	redirect_to :action => 'login' 
end

end
