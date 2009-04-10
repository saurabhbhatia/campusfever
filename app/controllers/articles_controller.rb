class ArticlesController < ApplicationController
	
	def index
		if params[:category_id]
			@articles_pages, @articles = paginate(:articles, :include => :faculty, :order => 'published_at DESC', :conditions => "category_id=#{params[:category_id].to_i} AND published=true")
		else
			@articles = Articles.find_all_by_published(true)
			@articles_pages, @articles = paginate(:articles, :include => :faculty, :order => 'published_at DESC', :conditions => "published=true")
		end
		respond_to do |wants|
			wants.html
			wants.xml { render :xml => @articles.to_xml }
			wants.rss { render :action => 'rss.xml', :layout => false }
			wants.atom { render :action => 'atom.rxml', :layout => false }
		end
	end
	
	def show
		if is_logged_in1?
			@faculty = Faculty.find(params[:faculty_id])
			@article = Article.find(params[:id])
		else
			@article = Article.find_by_id_and_published(params[:id], true)
		end
		respond_to do |wants|
			wants.html
			wants.xml { render :xml => @article.to_xml }
		end
	end
	
	def new
		@faculty = Faculty.find(params[:id])
		@article = Article.new
	end
	
	def create
		@faculty = Faculty.find(params[:id])
		@article = Article.new(params[:article])
		@article.faculty_id = @faculty.id
		@article.title = @article.title
		@article.synopsis = @article.synopsis
		@article.body = @article.body
		#@article.tags = @article.tags
		@article.category_id = params[:category]
		#@logged_in_faculty.articles << @article
		@article.save
		redirect_to :action => 'show', :id => @article, :faculty_id => @faculty
	end
	
	def edit
		@article = Article.find(params[:id])
	end
	
	def update
		@article = Article.find(params[:id])
		@article.update_attributes(params[:article])
		respond_to do |wants|
			wants.html { redirect_to faculty_articles_url }
			wants.xml { render :xml => @article.to_xml }
		end
	end
	
	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		respond_to do |wants|
			wants.html { redirect_to faculty_articles_url }
			wants.xml { render :nothing => true }
		end
	end
	
	def admin
		@articles_pages, @articles = paginate(:articles, :order => 'published_at DESC')
	end
end
