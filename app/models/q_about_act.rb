class QAboutAct < ActiveRecord::Base
  attr_accessible :activity_id, :qustion, :qustioner
  validates :qustion,  presence: true
  belongs_to :activity
end
