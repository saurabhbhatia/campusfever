# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	#helper :all # include all helpers, all the time
	
	include SimpleCaptcha::ControllerHelpers
	
	# See ActionController::RequestForgeryProtection for details
	# Uncomment the :secret if you're not using the cookie session store
	#protect_from_forgery # :secret => '444a4619c71100a219be485725c938df'
	include LoginSystem
	include LoginSystem1
	
	def pages_for(size, options = {})
		default_options = {:per_page => 10}
		options = default_options.merge options
		pages = Paginator.new self, size, options[:per_page], (params[:page]||1)
		pages
	end
end
