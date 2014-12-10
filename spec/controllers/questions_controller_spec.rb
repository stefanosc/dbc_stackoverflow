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


  describe "GET edit" do
    let(:question) { Question.create(title: "question1", content: "nice") }
    subject { get :edit, id: question }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the index template" do
      expect(subject).to render_template(:edit)
    end

    it "assigns the requested question to the @question variable" do
      subject
      expect(assigns(:question)).to eq(question)
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

   describe "PATCH update" do
    context "with valid attributes" do
      let(:question) { FactoryGirl.create(:question) }
      let(:attrs) { FactoryGirl.attributes_for(:question) }
      before { patch :update, {id: question, question: attrs} }

      it "updates the question in the database" do
        updated_question = Question.find_by(id: question.id)
        expect(updated_question.title).to eq(attrs[:title])
        expect(updated_question.content).to eq(attrs[:content])
      end

      it "redirects question_path" do
        question = Question.last
        expect(response).to redirect_to question
      end
      it "sets a flash success message" do
        expect(flash[:success]).not_to be nil
      end
    end

    context "with invalid attributes" do
      let(:question) { FactoryGirl.create(:question) }
      let(:attrs) { FactoryGirl.attributes_for(:invalid_question) }
      before { patch :update, {id: question, question: attrs} }

      it "does NOT update the question in the database" do
        expect(Question.last ).to eq(question)
      end
      it "renders the question/show template" do
        expect(response).to render_template :edit
      end
      it "sets a flash success message" do
        expect(flash[:danger]).not_to be nil
      end
    end
  end

  describe "PATCH vote" do
    context "with a valid question id" do
      let(:question) { FactoryGirl.create(:question) }
      subject {patch :vote, id: question.id, vote: 1}

      it "updates the question vote count in the database" do
        expect{subject}.to change{question.reload.votes}.by(1)
      end
      it "redirects question_path" do
        subject
        expect(response).to redirect_to question_path(question)
      end
      it "sets a flash success message" do
        subject
        expect(flash[:success]).not_to be nil
      end
    end

    context "with an invalid question id" do
      let(:question) { FactoryGirl.create(:question) }
      before { request.env["HTTP_REFERER"] = question_url(question) }
      subject {patch :vote, {id: 4, vote: 1}}

      it "Does NOT update the question vote count in the database" do
        expect{subject}.not_to change{question.reload.votes}
      end
      it "redirects question_path" do
        subject
        expect(response).to redirect_to :back
      end
      it "sets a flash danger message" do
        subject
        expect(flash[:danger]).not_to be nil
      end
    end

  end

end
