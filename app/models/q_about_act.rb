class QAboutAct < ActiveRecord::Base
  attr_accessible :activity_id, :qustion, :qustioner
  validates :qustion,  presence: true
  belongs_to :activity
  has_many :re_for_ques_for_act
end
