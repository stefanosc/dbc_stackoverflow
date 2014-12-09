class AnswersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @question = find_question_from_params
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(@question)
      flash[:success] = "Successfully created answer"
    else
      @answers = @question.answers
      flash[:danger] = ""
      @answer.errors.full_messages.each do |msg|
        flash[:danger] << msg + ", "
      end
      render "questions/show"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:title,:content)
  end

  def find_question_from_params
    Question.find_by(id: params[:question_id])
  end
end
