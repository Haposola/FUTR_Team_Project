class ComForAct < ActiveRecord::Base
  attr_accessible :activity_id, :content, :speaker
  belong_to :activity
end
