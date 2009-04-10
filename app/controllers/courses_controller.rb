class CoursesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @course_pages, @courses = paginate :courses, :per_page => 10
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
	@college = College.find(params[:id])
	@course = Course.new
  end

  def create
	@college = College.find(params[:id])
	@course = Course.new(params[:course])
	@course.college_id = @college.id
	if @course.save
		flash[:notice] = 'Course was successfully created.'
		redirect_to :action => 'list'
	else
		render :action => 'new'
	end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:notice] = 'Course was successfully updated.'
      redirect_to :action => 'show', :id => @course
    else
      render :action => 'edit'
    end
  end

  def destroy
    Course.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
