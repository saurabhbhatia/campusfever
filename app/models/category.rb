class Category < ActiveRecord::Base
	#has_many :clubs
	validates_uniqueness_of :category
	has_many :articles, :dependent => :nullify
	belongs_to :faculty
end
