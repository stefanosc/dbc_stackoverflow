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

  def edit
    @question = find_question
  end

  def update
    if @question = find_question
      if @question.update_attributes(question_params)
        redirect_to @question
        flash[:success] = "Successfully updated question"
      else
        flash[:danger] = ""
        @question.errors.full_messages.each do |msg|
          flash[:danger] << msg + ", "
        end
        render :edit
      end
    end
  end

  private
    def question_params
      params.require(:question).permit(:title,:content)
    end

    def find_question
      Question.find_by(id: params[:id])
    end
end
