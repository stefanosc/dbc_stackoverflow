require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do

  # describe "GET index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end



  describe "POST create" do
    context "with valid attributes" do
      let(:question) { Question.create(title: "question title", content: "content") }
      let(:attrs) { {title: "title", content: "answer content"} }
      before { post :create, {question_id: question.id, answer: attrs} }

      it "saves the answer to the database" do
        expect(Answer.count).to eq(1)
      end
      it "saves the answer associated to the question" do
        expect(question.answers.count).to eq(1)
        expect(question.answers.last.title).to eq(attrs[:title])
      end
      it "redirects question_path" do
        expect(response).to redirect_to question_path(question)
      end
      it "sets a flash success message" do
        expect(flash[:success]).not_to be nil
      end
    end

    context "with invalid attributes" do
      let(:question) { FactoryGirl.create(:question) }
      let(:attrs) { FactoryGirl.attributes_for(:invalid_answer, question: question) }
      before { post :create, {question_id: question.id, answer: attrs} }

      it "does NOT save the answer to the database" do
        expect(Answer.count).to eq(0)
      end
      it "renders the question/show template" do
        expect(response).to render_template("questions/show")
      end
      it "sets a flash success message" do
        expect(flash[:danger]).not_to be nil
      end
    end
  end


  describe "DELETE destroy" do
    context "with a valid answer id" do
      let(:answer) { FactoryGirl.create(:answer) }
      before do
        request.env["HTTP_REFERER"] = question_url(answer.question)
        delete :destroy, id: answer.id, question_id: answer.question
      end

      it "deletes the answer from the database" do
        expect(Answer.count).to eq(0)
      end
      it "redirects question_path" do
        expect(response).to redirect_to :back
      end
      it "sets a flash success message" do
        expect(flash[:success]).not_to be nil
      end
    end

    context "with an invalid answer id" do
      let(:answer) { FactoryGirl.create(:answer) }
      before do
        request.env["HTTP_REFERER"] = question_url(answer.question)
        delete :destroy, id: "invalid_id", question_id: answer.question
      end

      it "Does NOT delete the answer from the database" do
        expect(Answer.count).to eq(1)
      end
      it "redirects question_path" do
        expect(response).to render_template("questions/show")
      end
      it "sets a flash success message" do
        expect(flash.now[:danger]).not_to be nil
      end
      it "assigns the question of the answer to the @question variable" do
        expect(assigns(:question)).to eq(answer.question)
      end

      it "assigns the answers of the question to the @answers variable" do
        expect(assigns(:answers)).to include(answer)
      end
    end

  end

   describe "PATCH vote" do
    context "with a valid answer id" do
      let(:answer) { FactoryGirl.create(:answer) }
      subject {patch :vote, id: answer, question_id: answer.question , vote: 1}

      it "updates the answer vote count in the database" do
        expect{subject}.to change{answer.reload.votes}.by(1)
      end
      it "redirects question_path" do
        subject
        expect(response).to redirect_to question_path(answer.question)
      end
      it "sets a flash success message" do
        subject
        expect(flash[:success]).not_to be nil
      end
    end

    context "with an invalid question id" do
      let(:answer) { FactoryGirl.create(:answer) }
      before { request.env["HTTP_REFERER"] = question_url(answer.question) }
      subject {patch :vote, {id: "invalid id", question_id: answer.question, vote: 1}}

      it "Does NOT update the answer vote count in the database" do
        expect{subject}.not_to change{answer.reload.votes}
      end
      it "redirects to back" do
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
