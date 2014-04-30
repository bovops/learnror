require 'spec_helper'

describe QuestionsController do
  describe 'GET #index' do
    let(:questions) { create_list(:question, 5) }
    before { get :index }

    it 'assigns all questions to array' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) { create(:question) }

    before { get :show, id: question }

    it 'assign the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

end
