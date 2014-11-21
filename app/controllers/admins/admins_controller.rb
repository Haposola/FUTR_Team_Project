class Admins::AdminsController < ApplicationController
	before_filter :authenticate_admin!
	layout "admins"
	def index
		render :layout => false
	end
	def usrmgmt
		@log = SignedInLog.all
		@olnum = @log.length
		choose = params[:id]
		if choose == "all"
			@users = User.all
		end
		if choose == "applications"
			@users =User.where("realconfirm = ?","no")
		end
		if choose == "uncommon"
			@users = User.where("(category=? OR category=? OR category=?) AND realconfirm =?","club","official","commercial","yes")
		end
	end
	def cnfm
		user = User.find(params[:id])
		user.update_attributes(:realconfirm =>"yes")
		redirect_to '/admins/usrmgmt/all'
	end
	def actmgmt
	end
	def svcmgmt
	end
	def svcmgmt
	end
	def sndemail
	end
end