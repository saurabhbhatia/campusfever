class ExamsController < ApplicationController
	before_filter :check_administrator_role,
        :only => [:index, :destroy, :enable, :new, :create]
	before_filter :login_required, :only => [:edit, :update]
	
	def index
		list
		render :action => 'list'
	end
	
	# GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
	verify :method => :post, :only => [ :destroy, :create, :update ],
	:redirect_to => { :action => :list }
	
	def list
		#@exam_pages, @exams = paginate :exams, :per_page => 10
		#@exam_identification = @exam.id
		#@exam_identification = @exam.id
		@paper = Paper.find(params[:id])
		@user = User.find(params[:userid])
		#@exam = Exam.find(params[:id])
		if params[:picture_id]
			@picture = Picture.find(params[:picture_id])
		end
		#@exam = Exam.find(params[:id])
		#@paper = Paper.find(params[:id])
		#@other_params = Exam.find(params[:id])
	end
	
	def show
		@exam = Exam.find(params[:id])
		@paper = Paper.find(params[:paper_id])
		@user = User.find(params[:userid])
		if @exam.update_attributes(params[:exam])
			#flash[:notice] = 'Exam is successfully updated.'
		else
			render :action => 'edit'
		end
	end
	
	def new
		@user = User.find(params[:user_id])
		@paper = Paper.find(params[:id])
		#@exam = Exam.new(params[:exam])
		#@exam.c_name = params[:c_name]
		#@exam.c_year = params[:c_year]
		#@paper.test_name = @paper.test_name
		#@exam.exam_type = params[:exam_type]
		@exam = Exam.new
		#@exam.save
		#@exam_identification = @exam.id
	end
	
	def new1
		@picture = Picture.find(params[:id])
		@paper = Paper.find(params[:paper_id])
		@user = User.find(params[:userid])
		@exam = Exam.new
	end
	
	def create
		@user = User.find(params[:user_id])
		#@exam = Exam.find(params[:id])
		#@exam.c_name = params[:c_name]
		#@exam.c_year = params[:c_year]
		#@exam.exam_type = params[:exam_type]
		#@paper = Paper.find(params[:id])
		@exam = Exam.new(params[:exam])
		#@exam.papers.push_with_attributes(Paper.find(params[:paper][:id]))
		@exam.question = @exam.question
		@exam.option_a = @exam.option_a
		@exam.option_b = @exam.option_b
		@exam.option_c = @exam.option_c
		@exam.option_d = @exam.option_d
		@exam.option_e = @exam.option_e
		@answer = params[:opt_1]
		if @answer == "option_a"
			@exam.answer = @exam.option_a
		elsif @answer == "option_b"
			@exam.answer = @exam.option_b
		elsif @answer == "option_c"
			@exam.answer = @exam.option_c
		elsif @answer == "option_d"
			@exam.answer = @exam.option_d
		elsif @answer == "option_e"
			@exam.answer = @exam.option_e
		end
		
		@paper = Paper.find(params[:id])
		#@questions_of_exam = params[:exam]
		#@exam.question = @questions_of_exam.question
		if @exam.save
			@exam.papers.push_with_attributes(@paper)
			#@paper.exams.push_with_attributes(@exam)
			redirect_to :action => 'list', :id => @paper, :userid => @user
		else
			redirect_to :action => 'new'
		end
	end
			########## Code for Popup Starts Here
		#end
	#end
	
	def create1
		@paper = Paper.find(params[:id])
		#@exam = Exam.find(params[:id])
		#@exam.c_name = params[:c_name]
		#@exam.c_year = params[:c_year]
		#@exam.exam_type = params[:exam_type]
		#@paper = Paper.find(params[:id])
		@picture = Picture.find(params[:picture_id])
		@user = User.find(params[:userid])
		@exam = Exam.new(params[:exam])
		#@exam.papers.push_with_attributes(Paper.find(params[:paper][:id]))
		@exam.question = @exam.question
		@exam.option_a = @exam.option_a
		@exam.option_b = @exam.option_b
		@exam.option_c = @exam.option_c
		@exam.option_d = @exam.option_d
		@exam.option_e = @exam.option_e
		@exam.picture_id = @picture.id
		
		@answer = params[:opt_1]
		if @answer == "option_a"
			@exam.answer = @exam.option_a
		elsif @answer == "option_b"
			@exam.answer = @exam.option_b
		elsif @answer == "option_c"
			@exam.answer = @exam.option_c
		elsif @answer == "option_d"
			@exam.answer = @exam.option_d
		elsif @answer == "option_e"
			@exam.answer = @exam.option_e
		end
	
		#@questions_of_exam = params[:exam]
		#@exam.question = @questions_of_exam.question
		if @exam.save
			@exam.papers.push_with_attributes(@paper)
			#@paper.exams.push_with_attributes(@exam)
			redirect_to :action => 'list', :id => @paper, :userid => @user
		else
			redirect_to :action => 'new1'
		end
	end

	
	def edit
		#@exam = Exam.find(params[:exams_papers])
		#@exam = Exam.find(params[:id])
		#@paper = Paper.find(params[:id])
		@exam = Exam.find(params[:id])
		@paper = Paper.find(params[:paper_id])
		@user = User.find(params[:userid])
	end
	
	def update
		@exam = Exam.find(params[:id])
		@paper = Paper.find(params[:paper_id])
		if @exam.update_attributes(params[:exam])
			#flash[:notice] = 'Exam is successfully updated.'
			redirect_to :action => 'show', :id => @exam, :paper_id => @paper
		else
			render :action => 'edit'
		end
	end
	
	def destroy
		Exam.find(params[:id]).destroy
		@paper = Paper.find(params[:paper_id])
		@user = User.find(params[:userid])
		redirect_to :action => 'list', :id => @paper, :userid => @user
	end
	
	def start_exam
		@paper = Exam.new
	end
	
	def add_another
		@next_question = Exam.new(params[:exam])
		#@exam = Exam.find(params[:id])
		@paper = Paper.find(params[:id])
	end
	
	def new_create
		@next_question = Exam.new(params[:exam])
		@exam = Exam.find(params[:id])
		@exam.question = @next_question.question
		@exam.option_a = @next_question.option_a
		@exam.option_b = @next_question.option_b
		@exam.option_c = @next_question.option_c
		@exam.option_d = @next_question.option_d
		@exam.option_e = @next_question.option_e
		
		@answer = params[:opt_1]
		if @answer == "option_a"
			@exam.answer = @next_question.option_a
		elsif @answer == "option_b"
			@exam.answer = @next_question.option_b
		elsif @answer == "option_c"
			@exam.answer = @next_question.option_c
		elsif @answer == "option_d"
			@exam.answer = @next_question.option_d
		elsif @answer == "option_e"
			@exam.answer = @next_question.option_e
		end
		
		if @exam.save
			flash[:notice] = 'Exam was successfully created.'
			redirect_to :action => 'list', :id => @exam
			#redirect_to :action => 'list', :id => @question_id
		else
			render :action => 'new'
		end
	end
	
	def remove_exam
		@paper = Paper.find(params[:id])
		#@paper = Paper.find(params[:id])
		@exam.papers.delete(Exam.find(params[:which_exam]))
		if @exam.save
			flash[:notice] = 'Question has been Removed'
		end
		redirect_to :action => 'list', :id => @exam
	end
	
	def add_paper
		@paper = Paper.find(params[:id])
		@exam.papers.push_with_attributes(Paper.find(params[:paper][:id]))
		if @exam.save
			flash[:notice] = 'Keyword has been added!'
		end
		redirect_to :action => 'list', :id => params[:id]
	end
	
	def add_some_papers
		@exam = Exam.find(params[:id])
		@unused_papers = Paper.find(:all) - @exam.papers
		if @unused_papers.any?
			@papers_to_add = @unused_papers.select { |key|
			(@params['key'+key.id.to_s]['checked'] == '1')}
			@papers_to_add.each { |key|
			@exam.papers.push_with_attributes(key)}
		end
		if @papers_to_add.any? and @exam.save
			flash[:notice] = 'Keywords have been added!'
		end
		redirect_to :action => 'list', :id => @exam
	end
	
	def finish_exam
		@user = User.find(params[:user_id])
		@paper = Paper.find(params[:id])
		@option = params[:type1]
		@paper.exam_value = @option
		@option1 = params[:introduction]
		@paper.introduction = @option1
		@timer = Paper.new(params[:paper])
		@paper.timer = @timer.timer
		#@option1 = params[:timer]
		#@option2 = params[:timer1]
		#@option3 = params[:timer2]
		#@paper.timer =  @option1 + ' : ' + @option2 + ' : ' + @option3
		@paper.save
	end
	
	def play
		@user = User.find(params[:user_id])
		@paper = Paper.find(params[:id])
	end
	
	def testme
		@user = User.find(params[:user_id])
		@paper = Paper.find(params[:id])
		@performance = Performance.new
	end
	
	def analysis
		@user = User.find(params[:user_id])
		@paper = Paper.find(params[:id])
		@exam = Exam.find(params[:keyword])
		@performance = Performance.new(params[:performance])
		@performance.user_id = @user.id
		@performance.paper_id = @paper.id
		@count == 1;
		@answer = params[:opt] + @radioname.to_s
		if @exam.answer == "option_a"
			@performance.right = @count
		elsif @exam.answer == "option_b"
			@performance.right = @count
		elsif @exam.answer == "option_c"
			@performance.right = @count
		elsif @exam.answer == "option_d"
			@performance.right = @count
		elsif @exam.answer == "option_e"
			@performance.right = @count
		elsif @performance.wrong = @count
		end
	end
end
