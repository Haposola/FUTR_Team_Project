class Question < ActiveRecord::Base
  attr_accessible :Description, :Lable, :Nickname, :Topic, :Answer
  has_many :qanswers, :dependent => :delete_all
end
