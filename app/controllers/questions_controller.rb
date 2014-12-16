class QuestionsController < ApplicationController
  before_filter :set_question, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    lable=params[:lable]
    #@lable=params[:string]

    if (lable=="all"||lable==nil)
      @questions = Question.paginate(:page=>params[:page]||1,:per_page=>3)
      #  questiontmp=Question.all
    else    
       questiontmp = Question.where("lable = ? ", lable)
       @questions = questiontmp.paginate(:page=>params[:page]||1,:per_page=>3)
    end
    respond_with(@questions)
  end
 
  def show
    @question = Question.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  def new
    @question = Question.new
    respond_with(@question)
  end

  def edit
  end

  def create
    @question = Question.new(params[:question])
    @question.save
    respond_with(@question)
  end

  def update
    @question.update_attributes(params[:question])
    respond_with(@question)
  end

  def destroy
    @question.destroy
    respond_with(@question)
  end

  

  private
    def set_question
      @question = Question.find(params[:id])
    end
end
