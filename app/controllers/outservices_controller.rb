class OutservicesController < ApplicationController
  # GET /outservices
  # GET /outservices.json

  def index
    #@restaurants = Outservice_place.all
    @restaurants = Outservice_place.find(:all, :conditions =>["service_kind = ?",:restaurant])
    @ktvs = Outservice_place.find(:all, :conditions =>["service_kind = ?",:ktv])
    @bars = Outservice_place.find(:all, :conditions =>["service_kind = ?",:bar])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @outservices }
    end
  end

  # GET /outservices/1
  # GET /outservices/1.json
  def show
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @outservice }
    end
  end

  # GET /outservices/new
  # GET /outservices/new.json
  def new
    before_filter  :authenticate_admin!
    @restaurant = Restaurant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outservice }
    end
  end

  # GET /outservices/1/edit
  def edit
    @restaurant = Restaurant.find(:first, :conditions =>["name = ?",params[:name]])
  end

  # POST /outservices
  # POST /outservices.json
  def create
    @restaurant = Restaurant.new(params[:restaurant])

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to outservices_path, notice: 'Outservice was successfully created.' }
        format.json { render json: outservices_path, status: :created, location: outservices_path }
      else
        format.html { render action: "new" }
        format.json { render json: @outservice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /outservices/1
  # PUT /outservices/1.json
  def update
    @restaurant = Restaurant.find(params[:name])

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        format.html { redirect_to restaurant_path, notice: 'Outservice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @outservice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outservices/1
  # DELETE /outservices/1.json
  def destroy
    @outservice = Restaurant.find(:first, :conditions =>["name = ?",params[:name]])
    @outservice.destroy

    respond_to do |format|
      format.html { redirect_to outservices_url }
      format.json { head :no_content }
    end
  end


#---------------------outservices-------------------------------------------------

  def new_outservice
    @outservice_place = Outservice_place.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outservice }
    end
  end

  def create_outservice
    @outservice_place = Outservice_place.new(params[:outservice_place])

    respond_to do |format|
      if @outservice_place.save
        format.html { redirect_to outservices_path, notice: 'Outservice was successfully created.' }
        format.json { render json: outservices_path, status: :created, location: outservices_path }
      else
        format.html { render action: "new" }
        format.json { render json: @outservice.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_outservice
    @outservice_place = Outservice_place.find(:first, :conditions =>["service_kind = ? AND name = ?",
      params[:service_kind],params[:name]])
    @outservice_place.destroy

    respond_to do |format|
      format.html { redirect_to outservices_path }
      format.json { head :no_content }
    end
  end
  
  def show_outservice
    @outservice_place = Outservice_place.find(:first, :conditions =>["service_kind = ? AND name = ?",
      params[:service_kind],params[:name]])
    @usercomments = Outservice_comment.find(:all, :conditions =>["service_kind = ? AND name = ?",
      params[:service_kind],params[:name]])
    @user_comment = Outservice_comment.new()
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @outservice }
    end
  end

  def edit_outservice
    @outservice_place = Outservice_place.find(:first, :conditions =>["service_kind = ? AND name = ?",
      params[:service_kind],params[:name]])
  end

  def update_outservice
    @outservice_place = Outservice_place.find(:first, :conditions =>["service_kind = ? AND name = ?",
      params[:service_kind],params[:name]])
    respond_to do |format|
      if @outservice_place.update_attributes(params[:outservice_place])
        format.html { redirect_to outservices_path, notice: 'Outservice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @outservice.errors, status: :unprocessable_entity }
      end
    end
  end
#---------------------outservices-------------------------------------------------

#----------------------------outservice comments-----------------------------------------------
  def delete_outservice_comments
    @delete_comment = Outservice_comment.find(:first, :conditions =>["name = ? AND nickname = ? AND comment=? 
      AND service_kind=?",params[:name],params[:nickname],params[:comment],params[:service_kind]])
    @delete_comment.destroy

    respond_to do |format|
      format.html { redirect_to show_outservice_path }
      format.json { head :no_content }
    end
  end

  def add_outservice_comments
    #@usercomment = Restaurant_comment.new(params[:user_comment])
    #userlog = SignedInLog.checkout(cookies[:riskfit_token])
    #@user = User.find(:first, :conditions =>["email = ?",userlog.email])
    #nickname = @user.nickname
    #@usercomment.nickname =nickname
    #@usercomment.restaurant_name =restaurantname
    nickname=current_user.nickname;
    @usercomment = Outservice_comment.new(:service_kind=> params[:service_kind],:nickname => nickname, 
      :name => params[:name], :comment => params[:comment])
    respond_to do |format|
      if @usercomment.save
        format.html { redirect_to show_outservice_path, notice: 'Comment was successfully created.' }
        format.json { render json: outservices_path, status: :created, location: restaurant_path }
      else
        format.html { redirect_to show_outservice_path, notice: 'Comment failed.' }
      end
    end
  end

#----------------------------outservice comments-----------------------------------------------








  def new_restaurant
    @restaurant = Restaurant.new
    #@restaurant = Outservice_place.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outservice }
    end
  end

  def create_restaurant
    @restaurant = Restaurant.new(params[:restaurant])
    #@restaurant = Outservice_place.new(params[:outservice_place])

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to outservices_path, notice: 'Outservice was successfully created.' }
        format.json { render json: outservices_path, status: :created, location: outservices_path }
      else
        format.html { render action: "new" }
        format.json { render json: @outservice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outservices/1
  # DELETE /outservices/1.json
  def delete_restaurant
    @outservice = Restaurant.find(:first, :conditions =>["name = ?",params[:name]])
    @outservice.destroy

    respond_to do |format|
      format.html { redirect_to outservices_path }
      format.json { head :no_content }
    end
  end

  # GET /outservices/restaurant/:name
  def show_restaurant
    @restaurant = Restaurant.find(:first, :conditions =>["name = ?",params[:name]])
    @usercomments = Restaurant_comment.find(:all, :conditions =>["restaurant_name = ?",params[:name]])
    @user_comment = Restaurant_comment.new()
    #userlog = SignedInLog.checkout(cookies[:riskfit_token])
    #@user = User.find(:first, :conditions =>["email = ?",userlog.email])
    #restaurantname = params[:name]

    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @outservice }
    end
  end

  # GET /outservices/restaurant/:name/edit
  def edit_restaurant
    @restaurant = Restaurant.find(:first, :conditions =>["name = ?",params[:name]])
  end

  # PUT /outservices/restaurant/:name
  def update_restaurant
    @restaurant = Restaurant.find(:first, :conditions =>["name = ?",params[:name]])
    name =params[:restaurant][:name]
    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        format.html { redirect_to outservices_path, notice: 'Outservice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @outservice.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_restaurant_comments
    @delete_comment = Restaurant_comment.find(:first, :conditions =>["restaurant_name = ? AND nickname = ? AND comment=?",
      params[:name],params[:nickname],params[:comment]])
    @delete_comment.destroy

    respond_to do |format|
      format.html { redirect_to restaurant_path }
      format.json { head :no_content }
    end
  end

  def add_restaurant_comments
    #@usercomment = Restaurant_comment.new(params[:user_comment])
    userlog = SignedInLog.checkout(cookies[:riskfit_token])
    @user = User.find(:first, :conditions =>["email = ?",userlog.email])
    restaurantname = params[:name]
    nickname = @user.nickname
    #@usercomment.nickname =nickname
    #@usercomment.restaurant_name =restaurantname
    comment = params[:comment]
    @usercomment = Restaurant_comment.new(:nickname => nickname, 
      :restaurant_name => restaurantname, :comment => comment)
    respond_to do |format|
      if @usercomment.save
        format.html { redirect_to restaurant_path, notice: 'Comment was successfully created.' }
        format.json { render json: outservices_path, status: :created, location: restaurant_path }
      else
        format.html { redirect_to restaurant_path, notice: 'Comment failed.' }
      end
    end
  end

end
