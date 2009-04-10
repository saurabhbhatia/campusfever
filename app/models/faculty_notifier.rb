class FacultyNotifier < ActionMailer::Base
	
	def signup_notification(faculty)
		setup_email(faculty)
		@subject    += 'Please activate your new account'
		@body[:url]  = "http://YOURSITE/account/activate/#{faculty.activation_code}"
	end
	
	def activation(faculty)
		setup_email(faculty)
		@subject    += 'Your account has been activated!'
		@body[:url]  = "http://YOURSITE/"
	end
	
	protected
	
	def setup_email(faculty)
		@recipients  = "#{faculty.email}"
		@from        = "ADMINEMAIL"
		@subject     = "[YOURSITE] "
		@sent_on     = Time.now
		@body[:faculty] = faculty
	end
end
