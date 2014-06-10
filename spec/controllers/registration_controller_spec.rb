require 'rails_helper'

describe Devise::RegistrationsController do

  describe 'GET #new' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
    end

    it 'assigns a new User to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context 'with valid attributes' do
      it 'saves the new user' do
        expect { post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
      end
      it 'redirects to root_path' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'user not saved' do
        expect { post :create, user: attributes_for(:invalid_user) }.to_not change(User, :count)
      end
      it 're-render new view' do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

end