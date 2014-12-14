class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         :confirmable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :nickname, :nation, :name, :category, :realconfirm
  attr_accessible :group, :score, :level
  validates :nickname, presence: true
end
