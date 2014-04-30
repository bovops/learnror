require 'spec_helper'

describe QuestionsController do
  describe "GET #index" do
    let(:questions) { create_list(:question, 5) }
    before do
      get :index
    end

    it 'assigns all questions to array' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) { create(:question) }

    before do
      get :show, id: question
    end
    
    it 'assign the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'render show view' do
      expect(response).to render_template :show
    end
  end

end
