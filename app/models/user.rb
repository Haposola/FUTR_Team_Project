class User < ActiveRecord::Base
  attr_accessible :email, :nickname, :password, :password_confirmation, :pwd_key, :name, :nation
  
  validates :email, presence: true
  validates :password, confirmation: true, presence: true
  validates :password_confirmation, presence: true
  validates :nickname, presence: true

  def self.enc(pass,random_string)
  	Digest::MD5.hexdigest(pass)+Digest::MD5.hexdigest(random_string)
  end

  def self.random_string(len)
  	randstring = ""
  	chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  	1.upto(len){ |i| randstring << chars[ rand(chars.size-1) ] }
  	return randstring
  end
  def self.get_key(email)
  	transaction do 
  		User.find(:first, :conditions => ["email = ?", email ]).pwd_key
  	end
  end
end
