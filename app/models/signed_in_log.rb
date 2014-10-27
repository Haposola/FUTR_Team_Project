class SignedInLog < ActiveRecord::Base
  attr_accessible :email, :token
end
