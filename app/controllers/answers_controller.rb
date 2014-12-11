class AnswersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @question = find_question
    @answer = @question.answers.build(answer_params)
    respond_to do |format|
      if @answer.save
        format.html do
          redirect_to question_path(@question)
          flash[:success] = "Successfully created answer"
        end
        format.json do
          render json: @answer, :status => :created
        end
      else
        format.html do
          @answers = @question.answers
          flash[:danger] = ""
          @answer.errors.full_messages.each do |msg|
            flash.now[:danger] << msg + ", "
          end
          render "questions/show"
        end
        format.json do
          render :json => @answer.errors.full_messages, :status => :unprocessable_entity
        end
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if answer = Answer.find_by(id: params[:id])
      answer.destroy
      flash[:success] = "Succefully deleted answer"
      redirect_to :back
    else
      @question = Question.includes(:answers).find_by(id: params[:question_id])
      @answers = @question.answers
      flash.now[:danger] = "Cannot find answer to delete"
      render "questions/show"
    end
  end

  def vote
    if @answer = Answer.find_by(id: params[:id])
      @question = find_question
      vote = params[:vote].to_i
      @answer.votes += vote
      respond_to do |format|
        if @answer.save
        format.html do
            flash[:success] = "Successfully registered vote"
          redirect_to @question
        end
        format.json do
          render json: {id: @answer.id, votes: @answer.votes}, :status => :created
        end
        else
        format.html do
          flash[:danger] = "There was a problem with your vote doge"
        end
        end
      end
    end

  end

  private

  def answer_params
    params.require(:answer).permit(:title,:content)
  end

  def find_question
    Question.find_by(id: params[:question_id])
  end
end
