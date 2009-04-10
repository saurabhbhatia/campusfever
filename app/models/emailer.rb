class Emailer < ActionMailer::Base

  def contact(message, sent_at = Time.now)
	@subject    = 'Campusfever Account Confirmation'
	@recipients = message.email
	@from       = 'AirtleA.P'
	@sent_on    = sent_at
		@body['first_name'] = message.firstname
		@body['last_name']   = message.lastname
	@headers    = {}
	content_type "text/html"
  end

end
