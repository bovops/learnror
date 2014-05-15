require 'spec_helper'

describe AnswersController do
  let!(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do

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

end
