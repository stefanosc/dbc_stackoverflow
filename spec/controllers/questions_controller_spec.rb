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
    let(:question) { Question.create(title: "question1", content: "nice") }
    let(:answer) { question.answers.create(title: "Answer", content: "nice") }
    subject { get :show, id: question.id }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the index template" do
      expect(subject).to render_template(:show)
    end

    it "assigns the requested question to the @question variable" do
      get :show, id: question.id
      expect(assigns(:question)).to eq(question)
    end

    it "assigns the answers to requested question to the @answers variable" do
      get :show, id: question.id
      expect(assigns(:answers)).to eq([answer])
    end
  end

end
