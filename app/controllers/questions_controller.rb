class QuestionsController < ApplicationController
  def index
    @question = Question.new
    @questions = Question.all
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answers = @question.answers
    @answer = @question.answers.build
  end


end
