class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])        
  end

  # POST /users
  # POST /users.json
  def create
    
    email = params[:user][:email]
    password = params[:user][:password]
    pwd_confirm = params[:user][:password_confirmation]
    nick = params[:user][:nickname]
    pwd_key = User.random_string(20)
    enc_pwd = User.enc(password,pwd_key)
    enc_confirm = User.enc(pwd_confirm,pwd_key)
    name = params[:user][:name]
    nation = params[:user][:nation]
    @user = User.new(:email => email, :password => enc_pwd, :nickname =>nick,
                                      :password_confirmation => enc_confirm, :pwd_key => pwd_key, :name => name, :nation => nation)

    respond_to do |format|
      if  User.where(email: @user.email).first !=nil
          format.html { redirect_to new_user_path, notice: 'email already used' }
          format.json { render json: @user }
      else 
        if @user.save
          log = SignedInLog.create(:email => @user.email, :token => User.random_string(30))
          cookies[:riskfit_token]={:value => log.token, :expires => Time.now + 1.days}
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def signin
      @user=User.new
      @msg = 0
  end

  def signinChk
      @msg =1
      signin_usr = User.try_to_signin(params[:user][:email])
      if signin_usr && signin_usr!= nil
      	password = params[:user][:password]
      	@usr_key = signin_usr.pwd_key
      	@tr_pwd = User.enc(password,@usr_key)
      	if(   signin_usr.password == @tr_pwd      )  
          		@res=1 
          		cookies[:riskfit_token]={:value => User.random_string(30), :expires => Time.now + 1.days}
          		SignedInLog.create(:email =>signin_usr.email, :token =>cookies[:riskfit_token])
          		redirect_to signin_usr
      	else 
        		@res =0
        		@user=User.new
              	render 'signin.html.erb'
      	end
      else
      	@res =-1
        	@user=User.new
              render 'signin.html.erb'
       end
  end

  def logout
    SignedInLog.find(:first, :conditions =>["token = ?",cookies[:riskfit_token]]).destroy
    cookies.delete :riskfit_token
    redirect_to :controller => 'index', :action =>'index'
  end

end
