class UsersController < ApplicationController
	before_filter :check_administrator_role,
        :only => [:index, :destroy, :enable]
	before_filter :login_required, :only => [:edit, :update, :play_test]
	
	def index
		@users = User.find(:all)
		@user_pages, @users = paginate :users, :per_page => 5
		#list
		#render :action => 'list'
	end
	
	# GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
	#verify :method => :post, :only => [ :destroy, :create, :update ],
	# :redirect_to => { :action => :list }
	
	def list
		@user_pages, @users = paginate :users, :per_page => 10
	end
	
	def show
		@user = User.find(params[:id])
		#@user = User.find(params[:user][:email], params[:user][:password])
	end
	
	def show_by_firstname
		@user = User.find_by_firstname(params[:firstname])
		render :action => 'show'
	end
	
	def new
		@user = User.new
		@user.valid_with_captcha?
	end
	
	def create
		@user = User.new(params[:user])
		@user.state = params[:state_id]
		@user.city = params[:city_id]
		@user.college = params[:college_id]
		@user.course = params[:course_id]
		@user.branch = params[:branch_id]
		#if@user.save_with_captcha
		if @user.save_with_captcha
			#recipient = @user.email
			#Emailer.deliver_contact(recipient)
			my_message = Emailer::create_contact(@user)
			my_message.set_content_type 'text/html'
			Emailer::deliver my_message
			#self.logged_in_user = @user
			#flash[:notice] = "Your Account has been Created."
			redirect_to :action => 'send_mail', :id => @user
		else
			render :action => 'new'
		end
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:notice] = 'User was successfully updated.'
			redirect_to :action => 'show', :id => @user
		else
			render :action => 'edit'
		end
	end
	
	def destroy
		User.find(params[:id]).destroy
		if @user.update_attribute(:enabled, false)
			flash[:notice] = "User disabled"
		else
			flash[:error] = "There was a problem disabling this user."
		end
		redirect_to :action => 'index'
		#redirect_to :action => 'list'
	end
	
	def send_mail
		@user = User.find(params[:id])
	end
	
	def on_city_id_change
		render :update do |page|
			@colleges = City.find(params[:dom_value]).colleges
			page.replace_html 'select-b', :inline=>"<%= select 'city','college_id', @collegess.map {|o| [o.college, o.id]} %>"
		end
	end
	
	def my_action
		if simple_captcha_valid?
			render :text => 'Captcha Implemented Successfully'
		else
			render :text => 'There is some Problem Impplementing Captcha'
		end
	end
	
	def add_link_city
		@cities = City.find_all_by_state_id(params["state_id"])
	end
	
	def add_link_college
		@colleges = College.find_all_by_city_id(params["city_id"])
		#@cities = City.find(:first, :conditions => ["city = ?", params[:city_id]])
	end
	
	def add_link_course
		@courses = Course.find_all_by_college_id(params["college_id"])
	end
	
	def add_link_branch
		@branches = Branch.find_all_by_course_id(params["course_id"])
	end
	
	def add_college
		City.find(params[:id]).colleges.create(params[:college])
		flash[:notice] = 'College is Successfully added'
	end
	
	def status
		@user = User.find(params[:id])
		if @user.update_attribute(:status, true)
			flash[:notice] = "User Enabled"
		else
			flash[:error] = "There was a Problem Enabling the User"
		end
		redirect_to :action => 'index'
	end
	
	def play_test
		@user = User.find(params[:id])
	end
	
	def add_link_year
		@years = Paper.find_all_by_c_name(params["c_name"])
	end
	
	def moderation
		@user = User.find(params[:id])
		@state = State.find(:all)
		@state_pages, @states = paginate :states, :per_page => 5
	end
	
	def moderation1
		@user = User.find(params[:id])
		@city = City.find(:all)
		@city_pages, @cities = paginate :cities, :per_page => 5
	end
	
	def moderation2
		@user = User.find(params[:id])
		@college = College.find(:all)
	end
	
	def moderation3
		@user = User.find(params[:id])
		@course = Course.find(:all)
	end
	
	def faculty
		@user = User.find(params[:id])
		@faculties = Faculty.find(:all)
	end
	
        def list_faculty
		@user = User.find(params[:id])
		@faculties_pages, @faculties = paginate :faculties, :per_page => 10
	end
	
	def ask_question
		@user = User.find(params[:id])
		@faculty = Faculty.find(params[:fac_id])
	end
	
	def ask_question1
		@user = User.find(params[:id])
		@faculty = Faculty.find(params[:fac_id])
		@question = Question.new(params[:question])
		@question.user_id = @user.id
		@question.fac_id = @faculty.id
		if  @question.save
			flash[:notice] = " Your question has been sent to the faculty"
			redirect_to  :controller =>'pages',:action =>'new', :id => @user
		else
			render :action =>'ask_question', :id => @user
		end
	end
	
	def list_quest_ans
		@user = User.find(params[:id])
		@questions_pages, @questions = paginate :questions, :per_page => 10
	end 
	
	def view_my_question
		@user = User.find(params[:id])
		@question = Question.find(:all,:conditions =>["user_id = ?", @user.id])
	end 
	
	def view_my_ans
		@user = User.find(params[:id])
		@question = Question.find(params[:questid])
		@doubt = Doubt.find(:all, :conditions =>["question_id = ?", @question.id])
		@answer = Answer.find(:first,:conditions =>["question_id = ?", @question.id])
		@faculty = Faculty.find(:first, :conditions =>["id = ? ",@question.fac_id])
	end 
	
	def view_answer
		@user = User.find(params[:id])
		@question = Question.find(params[:questid])
		@answer = Answer.find(:all, :conditions =>["question_id = ?", @question.id])
	end
	
	def ask_doubt
		@user = User.find(params[:id])
		@question = Question.find(params[:questid])
		@doubt1 = Doubt.find(:all, :conditions =>["question_id = ?", @question.id])
		@answer = Answer.find(:first, :conditions =>["question_id = ?", @question.id])
		@faculty = Faculty.find(:first, :conditions =>["id = ? ",@question.fac_id])
	end
	
	def create_doubt
		@user = User.find(params[:id])
		@question = Question.find(params[:questid])
		@answer = Answer.find(:all, :conditions =>["question_id = ?", @question.id])
		@doubt = Doubt.new(params[:doubt])
		@doubt.user_id = @user.id
		@doubt.fac_id = @question.fac_id
		@doubt.answer = 'zero'
		@doubt.question_id = @question.id
		
		if  @doubt.save
			redirect_to :action =>'view_my_ans', :id => @user, :doubtid => @doubt, :questid => @question
		else
			render :action => 'ask_doubt', :id =>@user, :questid => @question
		end
	end
	
	def notice
		@user = User.find(params[:id])
	end
end
