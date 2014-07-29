require 'digest/sha1'
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :password

  has_many :transactions

  before_save :create_hashed_password
  after_save :erase_password

  def self.all_except(user_name="")
    
    if name != nil
    users = User.all - [User.find_by_name(user_name)]
    end
    return users

  end

  private

  def create_hashed_password
  	
  	unless password.blank?
  		self.salt = User.create_salt(self.name) if salt.blank?
  		self.hashed_password = User.create_hashed_password(password, salt)
  	end
  end

  def self.authenticate_user(name="" , password="")
  	user = User.find_by_name(name)
  	if user
  		if user.hashed_password == User.create_hashed_password(password, user.salt)
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

  def erase_password
    self.password = nil
  end

end
