require 'rails_helper'

describe AnswersController do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:other_answer) { create(:answer, question: question, user: other_user) }

  describe 'POST #create' do
    before { sign_in(user) }

    context 'with valid attributes' do
      it 'saves the new answer' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end

    end

    context 'with invalid attributes' do
      it 'answer not saved' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to_not change(Answer, :count)
      end

      it 'render create template' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end

    end
  end

  describe 'PATCH #update' do
    before { sign_in(user) }

    context 'his answer' do
      before { patch :update, id: answer, question_id: question, answer: {body: 'edited answer'}, format: :js }

      it 'assigns the requested answer to @answer' do
        expect(assigns(:answer)).to eq answer
      end
      it 'assigns the question' do
        expect(assigns(:question)).to eq question
      end

      it 'changes answer attributes' do
        answer.reload
        expect(answer.body).to eq 'edited answer'
      end

      it 'render update template' do
        expect(response).to render_template :update
      end
    end


    context 'not-owned answer' do
      before { patch :update, id: other_answer, question_id: question, answer: {body: 'new body'}, format: :js }

      it 'does not change answer attributes' do
        other_answer.reload
        expect(other_answer.body).to eq "My Answer"
      end

    end
  end

end
