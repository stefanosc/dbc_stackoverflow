class AnswersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @answer = Answer.new(answer_params)
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
end
