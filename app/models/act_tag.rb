class ActTag < ActiveRecord::Base
  attr_accessible :name, :picname
  belongs_to :activity
  def self.check(nam)
  	if candi = ActTag.find(:first, :conditions =>["name = ?",nam])
  		return "actTag/#{candi.picname}.jpg"
  	else 
  		return "actTag/default.jpg"
  	end
  end
end
