require 'digest/sha2'

class User < ActiveRecord::Base
	apply_simple_captcha
	
	attr_protected :hashed_password, :enabled
	attr_accessor :password
	
	has_and_belongs_to_many :roles
	has_and_belongs_to_many :performaces
	has_and_belongs_to_many :papers
	has_many :clubs
	has_many :rates
	has_many :questions
	
	validates_presence_of :firstname
	validates_presence_of :lastname
	validates_presence_of :email
	validates_presence_of :password, :if => :password_required?
	validates_presence_of :password_confirmation, :if => :password_required?
	
	validates_confirmation_of :password, :if => :password_required?
	#validates_uniqueness_of :email
	
	validates_length_of :firstname, :within => 3..64
	validates_length_of :lastname, :within => 3..64
	validates_length_of :email, :within => 5..128
	#validates_length_of :password, :within => 4..20, :if => :password_required?
	
	def before_save
		self.hashed_password = User.encrypt(password) if !self.password.blank?
	end
	
	def password_required?
		self.hashed_password.blank? || !self.password.blank?
	end
	
	def self.encrypt(string)
		return Digest::SHA256.hexdigest(string)
	end
	
	def self.authenticate(email, password)
		find_by_email_and_hashed_password(email, User.encrypt(password), true)
	end
	
	def has_role?(rolename)
		self.roles.find_by_name(rolename) ? true : false
	end
end
