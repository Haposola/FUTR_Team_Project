class Qanswer < ActiveRecord::Base
  attr_accessible :Answer, :Nickname
  belongs_to :questions, :counter_cache=> true
end
