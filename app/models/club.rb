class Club < ActiveRecord::Base
	#belongs_to :category
	belongs_to :user
	validates_presence_of  :name
	validates_uniqueness_of  :name, :scope => "category"
	validates_presence_of :description

  def photo=(photo_in)
	self.image = photo_in.read
  end

end
