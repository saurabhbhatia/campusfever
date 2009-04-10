module LoginSystem
protected

def is_logged_in?
	@logged_in_user = User.find(session[:user]) if session[:user]
end

def logged_in_user
	return @logged_in_user if is_logged_in?
end

def logged_in_user=(user)
	if !user.nil?
		session[:user] = user.id
		@logged_in_user = user
	end
end

def self.included(base)
	base.send :helper_method, :is_logged_in?, :logged_in_user
end

def check_role(role)
	unless is_logged_in? && @logged_in_user.has_role?(role)
	flash[:error] = "You do not have the permission to do that."
	redirect_to :controller => 'account', :action => 'login'
	end
end

def check_administrator_role
	check_role('Administrator')
end

def login_required
	unless is_logged_in?
	flash[:error] = "You must be logged in to do that."
	redirect_to :controller => 'account', :action => 'login'
	end
end

def check_clubs_editor_role
	check_role('Clubs Editor')
end

def check_exams_editor_role
	check_role('Exams Editor')
end

def check_college_editor_role
	check_role('College Editor')
end

end
