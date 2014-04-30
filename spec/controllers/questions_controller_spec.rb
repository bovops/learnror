require 'spec_helper'

describe QuestionsController do
  describe "GET #index" do
    it 'assigns all questions to array' do
      questions = create_list(:question, 5)
      get :index
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      get :index
      expect(response).to render_template :index
    end
  end

end
