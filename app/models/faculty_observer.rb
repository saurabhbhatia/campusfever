class FacultyObserver < ActiveRecord::Observer
	
	def after_create(faculty)
		FacultyNotifier.deliver_signup_notification(faculty)
	end
	
	def after_save(faculty)
		FacultyNotifier.deliver_activation(faculty) if faculty.recently_activated?
	end
end