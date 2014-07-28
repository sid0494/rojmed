require 'digest/sha1'
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :password

  before_save :create_hashed_password
  after_save :erase_password

  private

  def create_hashed_password
  	
  	unless password.blank?
  		self.salt = AdminUser.create_salt(self.first_name) if salt.blank?
  		self.hashed_password = AdminUser.create_hashed_password(password, salt)
  	end
  end

  def self.authenticate_user(name="" , password="")
  	user = User.find_by_mobile_no(name)
  	if user
  		if user.hashed_password == AdminUser.create_hashed_password(password, user.salt)
  			return user
  		end
  	end
  	return false
  end

  def self.create_salt(name="")
  	Digest::SHA1.hexdigest("You must know #{Time.now} as well as #{name}")
  end

  def self.create_hashed_password(password="", salt="")
  	Digest::SHA1.hexdigest("The hashed password has #{password} and #{salt}")
  end

end
