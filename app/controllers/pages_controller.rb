class PagesController < ApplicationController
	#before_filter :check_clubs_editor_role, :except => [:index, :show]
	before_filter :check_administrator_role, :only => [:destroy, :enable]
	before_filter :login_required, :only => [:index, :update, :viewreply, :givereply, :updatereply, :search1, :rate1]
	
	def index
		@club_pages, @clubs = paginate (:clubs,:conditions =>["type = ? ",'public'], :order =>'id DESC')
		@club = Club.find(:all)
		@category_pages, @categories = paginate (:categories, :order =>'id DESC')
	end
	
	def category
		@category= Category.new(params[:category])
		@category.save
		redirect_to :action=>'index'
	end
	
	def club
		@picture = Picture.find(params[:id])
		@category = Category.find(:all)
		@club=Club.new(params[:club])
		@club.picture_id = @picture.id
		@club.caption = @picture.comment
		@club.category=params[:category]
		#@club.save
		@answer=params[:type1]
		if @answer=="public"
			@club.type=@answer
		elsif @answer=="private"
			@club.type=@answer
		end
		
		if  @club.save
			@name=@club.name
			@des=@club.description
			@category=@club.category
			@club_id = @club.id
			redirect_to :action => 'show1', :id => @club_id
		else
			render :action=> 'new', :id=>@club_id
		end
	end
	
	def club1
		@category = Category.find(:all)
		@user = User.find(params[:id])
		@club=Club.new(params[:club])
		@club.category=params[:category]
		#@club.save
		@club.user_id = @user.id
		@answer=params[:type1]
		if @answer=="public"
			@club.type=@answer
		elsif @answer=="private"
			@club.type=@answer
		end
			
		if  @club.save
			@name=@club.name
			@des=@club.description
			@category=@club.category
			@club_id = @club.id 
			redirect_to ( :action => 'show1', :id => @club_id, :user_id => @user )
		else
			render :action=> 'new', :id=>@club_id
		end
	end
	
	def rate1
		@club = Club.find(params[:id])
		@user = User.find(params[:user_id])
		@rate = Rate.new(params[:rate])
		@rate.club_id = @club.id
		@answer=params[:rate3]
		if @answer=="best"
			@rate.rate=@answer
		elsif @answer=="good"
			@rate.rate=@answer
		elsif @answer=="average"
			@rate.rate=@answer
		elsif @answer=="bad"
			@rate.rate=@answer
		end 
		
		@rate.rate= @answer
		@rate1 = @answer
		@rate.user_id = @user.id
		# update rates given by user
		@res = Rate.update_all("rate = @answer", "user_id = @rate.user_id")
		@rate.save
		@rate2 = Rate.count (:conditions =>["club_id = ? and rate = ?", @club.id, 'best'])
		@rate3 = Rate.count (:conditions =>["club_id = ? and rate = ?", @club.id, 'good'])
		@rate4 = Rate.count (:conditions =>["club_id = ? and rate = ?", @club.id, 'average'])
		@rate5 = Rate.count (:conditions =>["club_id = ? and rate = ?", @club.id, 'bad'])
		@average = ((@rate2*4)+(@rate3*3)+(@rate4*2)+(@rate5*1))/(@rate2+@rate3+@rate4+@rate5) 
		if @average>0 and @average <=1
			@ans= "Bad"
		elsif @average>1 and @average <=2
			@ans= "Average"
		elsif @average>2 and @average <=3
			@ans= "Good"
		elsif @average>3 and @average <=4
			@ans= "Best"
		end
	end
	
	def search
		@search = Search.new(params[:search])
		#@search.save
		@search_id=@search.id
		@search_search=@search.search+"%"
		@search1 = Club.find(:all, :conditions =>["name LIKE ? ", @search_search])
	end
	@club_pages, @clubs = paginate (:clubs,:conditions =>["type = ? ",'public'], :order =>'id DESC')
	
	def show1
		@club1=Club.find(params[:id])
		@user = User.find(params[:user_id])
		@picture_id = @club1.picture_id
		@name=@club1.name
		@des=@club1.description
		@club_id1 = @club1.id
		@forum = Forum.find(:all, :conditions => ["clubid = ? ", @club_id1], :order => "id DESC", :limit => 5)
		@count = Forum.count (:conditions =>["clubid = ? ", @club_id1])
	end
	
	def display1
		@category=Category.find(params[:id])
		@category_name=@category.category
		@category_id=@category.id
		@club = Club.find(:all, :conditions => ["category = ? ", @category_name], :order => "id DESC", :limit => 5)
	end
	
	def newtopic
		@club = Club.find(params[:id])
	end
	
	def new
		@user = User.find(params[:id])
	end
	
	def new2
		@picture = Picture.find(params[:id])
	end
	
	def create
		
	end
	
	def showforum
		@club=Club.find(params[:id])
		@name1 =@club.name
		@des = @club.description
		@club_id = @club.id
		@count = Post.count[:id]
		@forum=Forum.new(params[:forum])
		@forum.clubid = @club.id
		@forum.clubname = @club.name
		@forum.picture_id = @club.picture_id
		@forum.save 
		@subject=@forum.subject
		@forum_id=@forum.id
		@list = Forum.find(:all, :conditions => ["clubid = ? ", @club_id],:order => "id DESC", :limit => 5)
		@count1 = Forum.count (:conditions =>["clubid = ? ", @club_id])
	end
	
	def viewreply
		@forum=Forum.find(params[:id])
		@forum_message=@forum.message
		@forum_id=@forum.id
		@forum_clubid = @forum.clubid
		@count = Post.count (:conditions =>["forumid = ? ", @forum_id])
		@post = Post.find(:all, :conditions => ["forumid = ? ", @forum_id], :order => 'id DESC', :limit => 5)
	end
	
	def givereply
		@forum=Forum.find(params[:id])
		@subject = @forum.subject
		@forum_id = @forum.id
		@clubname = @forum.clubname
	end
	
	def updatereply
		@forum=Forum.find(params[:id])
		@subject = @forum.subject
		@forum_id = @forum.id
		@post=Post.new(params[:post])
		@post.forumid = @forum.id
		@post.save
		@message=@post.message
		redirect_to ({:action => 'viewreply', :id => @forum_id})
	end
	
	def view_all
		@club=Club.find(params[:id])
		@name=@club.name
		@des=@club.description
		@club_id = @club.id 
		@forum = Forum.find(:all, :conditions => ["clubid = ? ", @club_id], :order => "id DESC")
	end
	
	def create1
		
	end
	
	def delete_club
		if request.post?
			@club = Club.find(params[:id])
			begin
			@club.destroy
			flash[:notice] = " #{@club.name} deleted"
			rescue Exception => e
			flash[:notice] = e.message
			end
		end
		redirect_to(:action => 'index')
	end
end
