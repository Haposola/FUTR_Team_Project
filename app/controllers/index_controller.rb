class IndexController < ApplicationController
	def index
		@service_restaurant = Outservice::Outservice_place.find(:first, :conditions =>["service_kind = ?",:restaurant])
    @service_ktv = Outservice::Outservice_place.find(:first, :conditions =>["service_kind = ?",:ktv])
    @service_bar = Outservice::Outservice_place.find(:first, :conditions =>["service_kind = ?",:bar])
    @activities = Activity.limit(3)
	end
end
