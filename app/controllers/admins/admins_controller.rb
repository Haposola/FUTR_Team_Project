class Admins::AdminsController < ApplicationController
	before_filter :authenticate_admin!
	layout "admins"
	def index
	end
	def usrmgmt
		choose = params[:id]
		if choose == "all"
			@users = User.all
		end
		if choose == "applications"
			@users =User.where("realconfirm = ?","no")
		end
		if choose == "uncommon"
			@users = User.where("category=? OR category=? OR category=?","club","official","commercial")
		end
	end

	def actmgmt
	end
	def svcmgmt
	end
	def svcmgmt
	end
end