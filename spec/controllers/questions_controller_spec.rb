require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  describe "GET index" do
    subject { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      expect(subject).to render_template(:index)
    end

    it "assigns all questions to the @questions variable" do
      question1 = Question.create(title: "question1", content: "nice")
      question2 = Question.create(title: "question2", content: "nice")
      get :index
      expect(assigns(:questions)).to eq([question1, question2])
    end
  end

  describe "GET show" do
    subject { get :show }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the index template" do
      expect(subject).to render_template(:show)
    end
  end

end
