class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answers = @question.answers
  end
end
