class ComForAct < ActiveRecord::Base
  attr_accessible :activity_id, :content, :speaker
  belongs_to :activity
end
