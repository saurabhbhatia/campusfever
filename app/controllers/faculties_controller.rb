class FacultiesController < ApplicationController

	def index
		@user = User.find(params[:id])
		@faculties = Faculty.find(:all)
	end
	
	# GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
	verify :method => :post, :only => [ :destroy, :create, :update ],
	:redirect_to => { :action => :list }
	
	def list
		@faculty_pages, @faculties = paginate :faculties, :per_page => 10
	end
	
	def check
		@checked_value = params[:branch][:branch_id]
		@faculty = Faculty.new(params[:faculty])
		if @faculty.save
				#@selected_branches = params[:branch_id]
				#@option << @selected_branches
				#@counter == 1;
				for i in @checked_value do
					@mybranch = Mybranch.new
					@mybranch.branch_id = i
					@mybranch.faculty_id = @faculty.id
					@mybranch.save
				end
		else
			render :action => 'error'
		end
	end

	def show_by_fac_displayname
		@faculty = Faculty.find_by_fac_displayname(parmas[:fac_displayname])
		render :action => 'show'
	end
	
	def show
		@faculty = Faculty.find(params[:id])
	end
	
	def new
		@faculty = Faculty.new
	end
	
	def create
		@faculty = Faculty.new(params[:faculty])
		if @faculty.save
			self.logged_in_faculty = @faculty
			flash[:notice] = 'Faculty created successfully.'
			redirect_to :action => 'thankyou'
			@faculty.course_id.branch_id.push_with_attributes(@faculty)
		else
			render :action => 'new'
		end
	end
	
	def edit
		@faculty = logged_in_faculty
	end
	
	def facultyadmin
		@faculty = Faculty.new(params[:faculty])
	end
	
	def update
		@faculty = Faculty.find(logged_in_faculty)
		if @faculty.update_attributes(params[:faculty])
			flash[:notice] = 'Faculty updated.'
			redirect_to :action => 'show', :id => logged_in_faculty
		else
			render :action => 'edit'
		end
	end
	
	def destroy
		@faculty = Faculty.find(params[:id])
		if @faculty.update_attribute(:enabled, false)
			flash[:notice] = "Faculty disabled"
		else
			flash[:error] = "There was a problem disabling this Faculty."
		end
		redirect_to :action => 'index'
	end
	
	def enable
		@faculty = Faculty.find(params[:id])
		if @faculty.update_attribute(:enabled, true)
			flash[:notice] = "Faculty enabled"
		else
			flash[:error] = "There was a problem enabling this Faculty Member."
		end
		redirect_to :action => 'index'
	end
	
	def welcome
		@faculty = Faculty.find(params[:id])
	end
	
	def view_profile
		@faculty = Faculty.find(params[:id])
		@user = User.find(params[:userid])
	end
	
	def view_question
		@faculty = Faculty.find(params[:id])
		@question = Question.find(:all, :conditions =>["fac_id = ?", @faculty.id], :order => 'id DESC')               
	end
	
	def reply
		@faculty = Faculty.find(params[:id])
		@question = Question.find(params[:questid])
		@user = User.find(:first, :conditions =>["id = ?", @question.user_id])
	end
	
	def create 
		@faculty = Faculty.find(params[:id])
		@question = Question.find(params[:questid])
		@answer = Answer.new(params[:answer])
		@faculty = Faculty.new(params[:faculty])
		@answer.question_id = @question.id
		@answer.fac_id = @faculty.id
		if   @answer.save
			flash[:notice] = "Your answer has been successfully given. "
			redirect_to :action =>'view_question', :id => @faculty
		else 
			render :action =>'reply', :id => @faculty, :questid => @question
		end 
	end
	
	def view_answer
		@faculty = Faculty.find(params[:id])
		@question = Question.find(params[:questid])
		@user = User.find(:first, :conditions =>["id = ?",@question.user_id])
		@answer = Answer.find(:all,:conditions =>["question_id = ? ",@question.id ])
	end
	
	def view_q_a
		@faculty = Faculty.find(params[:id])
		@question = Question.find(params[:questid])
		@answer = Answer.find(:first, :conditions =>["question_id = ?",@question.id])
		@doubt = Doubt.find(:all, :conditions =>["question_id = ?", @question.id])
	end
	
	def reply_doubt
		@doubtid = Doubt.find(params[:doubtid])
		@faculty = Faculty.find(params[:id])
		@question = Question.find(params[:questid])
		@answer = Answer.find(:first, :conditions =>["question_id = ?",@question.id])
		@doubt1 = Doubt.find(:first, :conditions =>["id = ?", @doubtid.id])
	end
	
	def answer_doubt
		@doubtid = Doubt.find(params[:doubtid])
		@faculty = Faculty.find(params[:id])
		@question = Question.find(params[:questid])
		@answerdoubt = Answerdoubt.new(params[:answerdoubt])
		@answer = @answerdoubt.answer
		@answerdoubt.doubt_id = @doubtid.id
		@doubt_id = @doubtid.id
		@answerdoubt.save
		@doubtid.answer = @answerdoubt.answer
		if @doubtid.save
			redirect_to :action =>'view_q_a', :id =>@faculty, :questid => @question
		else 
			render :action =>'reply_doubt', :id =>@faculty, :questid => @question, :doubtid=> @doubtid
		end
	end
	
	def add_link_branch
		@branches = Branch.find_all_by_course_id(params["course_id"])
	end
	
	def search
		@query=params[:query]
		@total, @articles = Article.full_text_search(@query, :page => (params[:page]||1))	  
		@pages = pages_for(@total)
	end
	
	def thankyou
	end
	
	def notice
		@faculty = Faculty.find(params[:id])
	end
	
	def send_file_note
		@faculty = Faculty.find(params[:id])
		@note = Note.new(params[:note])
		@note.sender = @faculty.id
		@note.save
	end
	
	def add_field
		render :partial => 'file_input'
	end
	
	def send_note
		@faculty = Faculty.find(params[:id])
		@note = Note.new(params[:note])
		@note.sender_id = @faculty.id
		@note.type = 'EventNote'
		@checked_branch = params[:branch][:branch_id]
		if @note.save
			for i in @checked_branch do
				@note_recipient = NoteRecipient.new
				@note_recipient.branch_id = i
				@note_recipient.faculty_id = @faculty.id
				@note_recipient.note_id = @note.id
				@note_recipient.save
			end
		else
			render :action => 'error'
		end
	end
end
