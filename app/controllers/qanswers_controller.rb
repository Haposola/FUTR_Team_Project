class QanswersController < ApplicationController
  before_filter :set_qanswer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @qanswers = Qanswer.all
    respond_with(@qanswers)
  end

  def show
    respond_with(@qanswer)
  end

  def new
    @qanswer = Qanswer.new
    respond_with(@qanswer)
  end

  def edit
  end

  def create
    @question = Question.find(params[:question_id])   
    @qanswer = @question.qanswers.new(params[:qanswer])   
    @qanswer.save
    redirect_to question_path(@question)   

  end

  def update
    @qanswer.update_attributes(params[:qanswer])
    respond_with(@qanswer)
  end

  def destroy
    @qanswer.destroy
    respond_with(@qanswer)
  end

  private
    def set_qanswer
      @qanswer = Qanswer.find(params[:id])
    end
end
