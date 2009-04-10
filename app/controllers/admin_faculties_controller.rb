class AdminFacultiesController < ApplicationController
	
	def new
		@user = User.find(params[:id])
		@faculty = Faculty.new
	end
	
	def create
		@faculty = Faculty.new(params[:faculty])
		@faculty.state_id = params[:state_id]
		@faculty.city_id = params[:city_id]
		@faculty.college_id = params[:college_id]
		if @faculty.save
			render :text => "Thank You"
		else
			redirect_to :action => 'list'
		end
	end
	
	def add_link_city
		@cities = City.find_all_by_state_id(params["state_id"])
	end
	
	def add_link_college
		@colleges = College.find_all_by_city_id(params["city_id"])
		#@cities = City.find(:first, :conditions => ["city = ?", params[:city_id]])
	end
	
end