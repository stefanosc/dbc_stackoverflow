class QuestionsController < ApplicationController
  def index
    @question = Question.new
    @questions = Question.all
    # @quote = GithubZen.get_quote
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answers = @question.answers
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.html do
          redirect_to @question
          flash[:success] = "Successfully created question"
        end
        format.json do
          render json: @question, :status => :created
        end
      else
        format.html do
          @question = Question.new
          @questions = Question.all
          flash[:danger] = ""
          @question.errors.full_messages.each do |msg|
            flash[:danger] << msg + ", "
          end
          render :index
        end
        format.json do
          render :json => @question.errors.full_messages, :status => :unprocessable_entity
        end
      end
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

  def vote
    if @question = find_question
      vote = params[:vote].to_i
      @question.votes += vote
      if @question.save
        flash[:success] = "Successfully registered vote"
      else
        flash[:danger] = "There was a problem with your vote doge"
      end
      redirect_to @question
    else
      flash[:danger] = "There was a problem with your vote doge"
      redirect_to :back
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
