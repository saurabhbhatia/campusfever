class Group < ActiveRecord::Base
	has_many :group_memberships, :dependent => :destroy
	has_many :faculties, :through => :group_memberships#, :unique => true
	belongs_to :owner, :class_name => "Faculty", :foreign_key => 'owner_id'
	has_many :notes
	
	validates_presence_of :name
end
