class Users::UsersController < ApplicationController
	def index
		@myAct = Activity.where("owner = ?", current_user.email)
		@myFootprint = Outservice::Outservice_comment.where("nickname = ?", current_user.nickname)
	end
	def info
	end
	def regist
	end
end