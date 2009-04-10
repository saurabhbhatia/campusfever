class FriendshipMailer < ActionMailer::Base
	def request_friend(current_faculty, faculty)
		setup_email(faculty)
		body[:requester] = current_faculty
	end
	
	def accept_request(current_faculty, faculty)
		setup_email(faculty)
		body[:acceptor] = current_faculty
	end
	
	protected
	def setup_email(faculty)
		@recipients  = "#{faculty.email}"
		@from        = "ADMINEMAIL"
		@subject     = "[Pownce] "
		@sent_on     = Time.now
		@body[:faculty] = faculty
	end
end
