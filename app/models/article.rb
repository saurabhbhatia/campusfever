class Article < ActiveRecord::Base
	
	acts_as_ferret :fields => [ 'id', 'body', 'title', 'tags', 'long_article' ]
	
	belongs_to :faculty
	belongs_to :category
	
	validates_presence_of :title
	validates_presence_of :synopsis
	validates_presence_of :body
	validates_length_of :title, :maximum => 255
	validates_length_of :synopsis, :maximum => 1000
	validates_length_of :body, :maximum => 20000
	
	before_save :update_published_at
	
	def update_published_at
		self.published_at = Time.now if published == true
	end
	
	#def long_article
		#self.body.length > 40
	#end
	
	#def self.full_text_search(q, options = {})
		#return nil if q.nil? or q==""
		#default_options = {:limit => 10, :page => 1}
		#options = default_options.merge options
		#options[:offset] = options[:limit] * (options.delete(:page).to_i-1)  
		#results = Article.find_by_contents(q, options)
		#return [results.total_hits, results]
	#end
end
