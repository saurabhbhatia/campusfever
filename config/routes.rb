ActionController::Routing::Routes.draw do |map|
  map.resources :admin_faculties

	#map.resources :faculty_admin

	# The priority is based upon order of creation: first created -> highest priority.
	# Sample of regular route:
	#   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
	# Keep in mind you can assign values other than :controller and :action
	
	map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
	
	# Sample of named route:
	#   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
	# This route can be invoked with purchase_url(:id => product.id)
	
	# Sample resource route (maps HTTP verbs to controller actions automatically):
	#   map.resources :products
	
	# Sample resource route with options:
	#   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }
	
	# Sample resource route with sub-resources:
	#   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
	
	# Sample resource route within a namespace:
	#   map.namespace :admin do |admin|
	#     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
	#     admin.resources :products
	#   end
	
	# You can have the root of your site routed with map.root -- just remember to delete public/index.html.
	# map.root :controller => "welcome"
	map.connect 'adminfaculty/:action', :controller => 'adminfaculty', :action => 'action'
	
	# See how all your routes lay out with "rake routes"
	
	# Install the default routes as the lowest priority.
	
	map.index '/', :controller => 'pages',
	:action => 'new',
	:id => 'logged_in_user'
	
	#map.resources :papers
	map.resources :users
	map.resources :faculties
	map.resources :users, :member => { :status => :put }
	#map.resources :users, :member => { :status => :put } do |users|
	#users.resources :roles
	map.resources :exams, :collection => {:admin => :get}
	map.resources :clubs, :collection => {:admin => :get}
	map.resources :categories, :collection => {:admin => :get} do |categories|
		categories.resources :clubs, :name_prefix => 'category_'
	end
	
	map.group_add 'groups', :controller => 'group', :action => 'add'
	map.main ':faculty', :controller => "main", :action => "main"
	
	map.friend 'friends', :controller => 'friend', :action => 'index'
	map.request_friend 'friends/request/:faculty_id', :controller => 'friend', :action => 'request_friend'
	map.accept_friend 'friends/accept/:faculty_id', :controller => 'friend', :action => 'accept_friend'
	map.unfriend_friend 'friends/unfriend/:faculty_id', :controller => 'friend', :action => 'unfriend'
	map.cancel_friend 'friends/cancel/:faculty_id', :controller => 'friend', :action => 'cancel_friend'
	map.delete_friend 'friends/delete/:faculty_id', :controller => 'friend', :action => 'delete'
	map.private_group 'private_groups/:action/:id', :controller => 'private_group'

	map.resources :faculties, :member => { :enable => :put }
	map.resources :articles
	
	map.reply_note 'notes/:note_id', :controller => "main", :action => "reply_note", :note_id => /\d+/
	map.delete_note 'notes/:note_id/delete_note', :controller => "main", :action => "delete_note", :note_id => /\d+/
	map.forward_note 'notes/:note_id/forward', :controller => "main", :action => "forward_note", :note_id => /\d+/
	
	map.index '', :controller => 'main', :action => "index"
	map.main ':faculty', :controller => "main", :action => "main"
	
	map.send_note ':faculty/send_note', :controller => "main", :action => "send_note"
	map.send_note ':faculty/send_file_note', :controller => "main", :action => "send_file_note"
	#map.filter ':faculty/:filter', :controller => "main", :action => "main"

	map.show_user '/user/:firstname',
	:controller => 'users',
	:action => 'show_by_firstname'
	map.show_faculty '/faculty/:fac_displayname',
	:controller => 'faculties',
	:action => 'show_by_fac_displayname'
	map.connect ':controller/:action/:id'
	map.connect ':controller/:action/:id.:format'

end
