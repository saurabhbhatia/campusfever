class MyMailer1 < ActionMailer::Base
	
	def newsletteruser(message, sent_at = Time.now)
		@subject    = 'Campusfever Account Confirmation'
		@body['first_name'] = message.firstname
		@body['last_name']   = message.lastname
		@recipients = message.email
		@from       = 'AirtleA.P'
		@sent_on    = sent_at
		@headers    = {}
		content_type "text/html"
	end
	
end