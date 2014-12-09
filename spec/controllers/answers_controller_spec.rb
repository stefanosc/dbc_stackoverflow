require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end



  describe "POST create" do

    let(:question) { Question.create(title: "question title", content: "content") }
    let(:attrs) { {title: "title", content: "answer content"} }
    before { post :create,  answer: attrs }

    it "saves the answer to the database" do
      expect(Answer.count).to eq(1)
    end
    it "saves the answer associated to the question" do
      expect(question.answers.count).to eq(1)
      expect(question.answers.last.title).to eq(attrs[:title])
    end
    it "redirects questions_path" do
      expect(response).to redirect_to question_path(question)
    end
    it "sets a flash success message" do
      expect(flash[:success]).not_to be nil
    end
  end

  # describe "GET edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
