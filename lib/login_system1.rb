module LoginSystem1
protected

def is_logged_in1?
	@logged_in_faculty = Faculty.find(session[:faculty]) if session[:faculty]
end

def logged_in_faculty
	return @logged_in_faculty if is_logged_in1?
end

def logged_in_faculty=(faculty)
	if !faculty.nil?
		session[:faculty] = faculty.id
		@logged_in_faculty = faculty
	end
end

def self.included(base)
	base.send :helper_method, :is_logged_in1?, :logged_in_faculty
end
end