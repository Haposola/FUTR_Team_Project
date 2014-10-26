class User < ActiveRecord::Base
  attr_accessible :email, :name, :nation, :nickname, :password, :password_confirmation
  validates :email, presence: true
  validates :password, confirmation: true, presence: true
  validates :password_confirmation, presence: true
  validates :nickname, presence: true
end
