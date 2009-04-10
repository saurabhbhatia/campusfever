class PapersController < ApplicationController
	before_filter :check_administrator_role, :only => :listing
	before_filter :login_required, :only => [:search]
	
	def start_exam
		@user = User.find(params[:id])
	end
	
	def new
		@user = User.find(params[:id])
		@paper = Paper.new(params[:paper])
		@paper.c_name = params[:c_name]
		@paper.c_year = params[:c_year]
		#@paper.test_name = @paper.test_name
		@paper.exam_type = params[:exam_type]
		#@paper.admin_id = @user.id
		#@exam = Exam.new
		@paper.admin_id = @user.id
		@paper.save
		#@exam_identification = @exam.id
		redirect_to :controller => '/exams', :action => 'new', :id => @paper, :user_id => @user
	end
	
	def search
		@user = User.find(params[:user_id])
		@search = Search.new(params[:search])
		#@search.save
		@search_id=@search.id
		@search_search=@search.search+"%"
		@search1 = Paper.find(:all, :conditions =>["c_name LIKE ? and exam_value LIKE ? ", @search_search, 'publish'])
		#@creator = User.find(:first, :conditions => ["admin_id LIKE ?"])
	end
	@paper_pages, @papers = paginate (:papers,:conditions =>["exam_value = ? ",'publish'], :order =>'id DESC')
	
	def search1
		@user = User.find(params[:id])
		@search2 = Paper.find(:all, :conditions => ["c_name LIKE ? ", "c_year LIKE ? "])
	end
	
	def listing
		@user = User.find(params[:id])
		@paper = Paper.find(:all, :conditions => ["admin_id = ?", params[:id]])
	end
end
