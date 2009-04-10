class Forum < ActiveRecord::Base

  validates_presence_of :subject
  validates_presence_of :message

  belongs_to :club, :counter_cache => true
  has_many :posts, :dependent => :delete_all

end
