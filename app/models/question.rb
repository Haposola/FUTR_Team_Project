class Question < ActiveRecord::Base
  attr_accessible :Description, :Lable, :Nickname, :Topic, :Answer
end
