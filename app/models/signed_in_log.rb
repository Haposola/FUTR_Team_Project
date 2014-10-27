class SignedInLog < ActiveRecord::Base
  attr_accessible :email, :token
  def self.checkout(token)
  	transaction do
  		SignedInLog.find(:first, :conditions => ["token = ?",token])
  	end
  end
end
