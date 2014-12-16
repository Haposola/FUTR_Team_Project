class QuesAnsReply < ActiveRecord::Base
  belongs_to :qanswer
  attr_accessible :anser, :body
end
