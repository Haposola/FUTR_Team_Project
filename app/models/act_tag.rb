class ActTag < ActiveRecord::Base
  attr_accessible :name
  belongs_to :activity
end
