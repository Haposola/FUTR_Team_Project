class Qanswer < ActiveRecord::Base
  attr_accessible :Answer, :Nickname
  belongs_to :question
end
