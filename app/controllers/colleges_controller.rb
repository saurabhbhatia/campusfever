class CollegesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
        :redirect_to => { :action => :list }

  def list
	@college_pages, @colleges = paginate :colleges, :per_page => 10
  end

  def show
	@college = College.find(params[:id])
  end

  def new
	@city = City.find(params[:id])
	#@city = City.find_by_state_id(params["state_id"])
	#@college = College.find_by_city_id(params["city_id"])
	@college = College.new
  end

  def create
	@city = City.find(params[:id])
	@college = College.new(params[:college])
	@college.city_id = @city.id
	if @college.save
		flash[:notice] = 'College was successfully created.'
		redirect_to :action => 'list'
	else
		render :action => 'new'
	end
  end

  def edit
    @college = College.find(params[:id])
  end

  def update
    @college = College.find(params[:id])
    if @college.update_attributes(params[:college])
      flash[:notice] = 'College was successfully updated.'
      redirect_to :action => 'show', :id => @college
    else
      render :action => 'edit'
    end
  end

  def destroy
    College.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
