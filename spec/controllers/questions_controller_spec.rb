require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  describe "GET index" do
    subject { get :index }

    it "instantiate a new @question" do
      get :index
      expect(assigns(:question)).to be_new_record
    end

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
    let!(:answer) { question.answers.create(title: "Answer", content: "nice") }
    subject { get :show, id: question }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the index template" do
      expect(subject).to render_template(:show)
    end

    it "assigns the requested question to the @question variable" do
      subject
      expect(assigns(:question)).to eq(question)
    end

    it "assigns the answers of the requested question to the @answers variable" do
      subject
      expect(assigns(:answers)).to include(answer)
    end
  end

   describe "POST create" do
    context "with valid attributes" do
      let(:attrs) { FactoryGirl.attributes_for(:question) }
      before { post :create, question: attrs }

      it "saves the question to the database" do
        expect(Question.count).to eq(1)
      end

      it "redirects question_path" do
        question = Question.last
        expect(response).to redirect_to question_path(question)
      end
      it "sets a flash success message" do
        expect(flash[:success]).not_to be nil
      end
    end

    context "with invalid attributes" do
      let(:attrs) { FactoryGirl.attributes_for(:invalid_question) }
      before { post :create, question: attrs }

      it "does NOT save the question to the database" do
        expect(Question.count).to eq(0)
      end
      it "renders the question/show template" do
        expect(response).to render_template :index
      end
      it "sets a flash success message" do
        expect(flash[:danger]).not_to be nil
      end
    end
  end

end
