require 'spec_helper'

describe AnswersController do
  let(:question) { create(:question) }

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

end
