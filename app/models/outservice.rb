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

class Outservice_place < ActiveRecord::Base
   attr_accessible :service_kind, :name, :picture_addr, :description, :cnt, :star
   validates :service_kind, :name, :description,  presence: true

   mount_uploader :picture_addr, UserAvatarUploader
end

class Outservice_comment < ActiveRecord::Base
   attr_accessible :service_kind, :nickname, :name, :comment, :star
   validates :service_kind, :nickname, :name, :comment, presence: true
end

