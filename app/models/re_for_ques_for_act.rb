class ReForQuesForAct < ActiveRecord::Base
  attr_accessible :answer, :q_about_act_id, :replier
  belongs_to :q_about_act
end
