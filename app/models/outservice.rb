class Outservice < ActiveRecord::Base
   attr_accessible :title, :body
end
class Restaurant < ActiveRecord::Base
   attr_accessible :name, :picture_addr, :description, :star
   validates :name, :picture_addr, :description, presence: true
end
class Restaurant_comment < ActiveRecord::Base
   attr_accessible :nickname, :restaurant_name, :comment, :star
   validates :nickname, :restaurant_name, :comment, presence: true
end

