class Users::UsersController < ApplicationController
	def index
		@myAct = Activity.where("owner = ?", current_user.email).order(:created_at).take(4)
		@myFootprint = Outservice::Outservice_comment.where("nickname = ?", current_user.nickname).order(:created_at).take(4)
	end
	def show
		alt=params[:alt]
		if(alt=="info")
			render "info.html.erb"
		end
		if(alt=="activities")
			@myAct=Activity.where("owner = ?", current_user.email).order(:created_at)
			render "activities.html.erb"
		end
		if(alt=="footprint")
			@myFootprint=Outservice::Outservice_comment.where("nickname = ?", current_user.nickname).order(:created_at)
			render "footprint.html.erb"
		end
	end
	def regist
	end
end