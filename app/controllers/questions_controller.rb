class QuestionsController < ApplicationController
  def index
    @question = Question.new
    @questions = Question.all
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answers = @question.answers
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
      flash[:success] = "Successfully created question"
    else
      @question = Question.new
      @questions = Question.all
      flash[:danger] = ""
      @question.errors.full_messages.each do |msg|
        flash[:danger] << msg + ", "
      end
      render :index
    end
  end


  private
    def question_params
      params.require(:question).permit(:title,:content)
    end


end
