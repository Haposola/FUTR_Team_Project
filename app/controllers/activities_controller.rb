class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.json
  def list
    category=params[:string]
    if(category=="all")
      activities = Activity.all
    else
      emails=[]
      User.find_each(:conditions=>["category=?",category]) do |u|
        emails << u.email
      end
      activities=[]
      emails.each do |e|
         Activity.find_each(:conditions=>["owner=?",e]) do |a|
          activities <<a
        end
      end
  end
    @pagenum = params[:id].to_i-1

    @pagetotal = activities.length/10+1
    activitiestmp= []
    activities.each do |a|
      activitiestmp << a
    end
    @activities = []
    for i in 0..9 do 
      if @pagenum*10+i <activitiestmp.length
        @activities << activitiestmp[@pagenum*10+i]
      end
    end

  end


  def index
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])
    @q_about_act = QAboutAct.new
    @reply = ReForQuesForAct.new
    @comment =  ComForAct.new
    @q_about_act.activity_id = @activity.id
    @questions = QAboutAct.where("activity_id = ?", @activity.id)
    @picpath = ActTag.check("")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new
    tags = ActTag.all
    @tags = []
    tags.each do |t|
      @tags << t.name
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    tags = ActTag.all
    @tags = []
    tags.each do |t|
      @tags << t.name
    end
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])
    @activity.owner = current_user.email
    @tag = ActTag.new(:name => @activity.tag,:picname => "default")
    respond_to do |format|
      if @activity.save && @tag.save
        format.html { redirect_to @activity }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to :action =>'list', :id =>1 }
      format.json { head :no_content }
    end
  end
  def newQuestion
    actId = params[:id]
    @question = QAboutAct.new(params[:q_about_act])
    @question.activity_id = actId
    @question.qustioner = current_user.nickname
    @question.save
    redirect_to Activity.find(actId)
  end
  def newReply
    queId=params[:id]
    @reply = ReForQuesForAct.new(params[:re_for_ques_for_act])
    @reply.q_about_act_id = queId
    @reply.replier = current_user.nickname
    @reply.save
    redirect_to Activity.find(QAboutAct.find(queId).activity_id)
  end
  def newComment
    actId = params[:id]
    @comment = ComForAct.new(params[:com_for_act])
    @comment.activity_id = actId
    @comment.speaker = current_user.nickname
    @comment.save
    redirect_to Activity.find(actId)
  end
end
