class OutservicesController < ApplicationController
  # GET /outservices
  # GET /outservices.json
  def index
    @restaurants = Restaurant.all

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

  def new_restaurant
    @restaurant = Restaurant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outservice }
    end
  end

  def create_restaurant
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
