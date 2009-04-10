require 'digest/sha1'

class Faculty < ActiveRecord::Base
	
	PROFILE_ATTRIBUTE_PRIVATE = 0
	PROFILE_ATTRIBUTE_FRIEND  = 1
	PROFILE_ATTRIBUTE_PUBLIC  = 2

	has_many :articles
	has_many :answers
	has_many :courses
	has_many :branches
	has_many :note_recipients
	attr_protected :hashed_password, :enabled
	attr_accessor :password

	validates_presence_of :email
	validates_presence_of :fac_displayname
	#validates_presence_of :fac_department
	#validates_presence_of :fac_edudetails
	#validates_presence_of :gender
	validates_presence_of :password, :if => :password_required?
	validates_presence_of :password_confirmation, :if => :password_required?
	
	validates_confirmation_of :password, :if => :password_required?

	validates_length_of :email, :within => 5..128
	validates_length_of :fac_displayname, :within => 3..64
	#validates_length_of :fac_edudetails, :within => 3..64
	
	has_many :friendships
	
	#groups (friends groups)
	has_many :owned_groups, :class_name => 'Group', :foreign_key => 'owner_id'
	has_many :group_memberships
	has_many :groups, :through => :group_memberships
	
	#private groups
	has_many :owned_private_groups, :class_name => 'PrivateGroup', :foreign_key => 'owner_id' 
	has_many :private_group_memberships, :dependent => :destroy
	has_many :private_groups, :through => :private_group_memberships#, :unique => true
	
	#notes
	has_many :sent_notes, :class_name => 'Note', :foreign_key => 'sender_id', :order => "created_at DESC"
	has_many :note_recipients
	has_many :received_notes, :through => :note_recipients, :source => :note, :order => "created_at DESC"
	
	# Social network and IM
	has_many :sn_memberships
	has_many :social_networks, :through => :sn_memberships 
	has_many :im_memberships
	has_many :ims, :through => :im_memberships
	has_many :websites
	
	#picture
	#has_attachment :content_type => :image, 
	#:storage => :file_system, 
	#:max_size => 5.megabytes
	
	def name
		fac_displayname
	end
	
	def before_save
		self.hashed_password = Faculty.encrypt(password) if !self.password.blank?
	end
	
	def password_required?
		self.hashed_password.blank? || !self.password.blank?
	end
	
	def self.encrypt(string)
		return Digest::SHA256.hexdigest(string)
	end
	
	def self.authenticate(email, password)
		find_by_email_and_hashed_password(email, Faculty.encrypt(password), true)
	end
	
	def remember_token?
		remember_token_expires_at && Time.now.utc < remember_token_expires_at
	end
	
	def remember_me
		self.remember_token_expires_at = 2.weeks.from_now.utc
		self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
		save(false)
	end
	
	def forget_me
		self.remember_token_expires_at = nil
		self.remember_token            = nil
		save(false)
	end
	
	def self.find_or_create_by_identity_url
		if !@faculty = Faculty.find_by_identity_url(identity_url)
			@faculty = Faculty.new(:identity_url => identity_url)
		end
	end
end
