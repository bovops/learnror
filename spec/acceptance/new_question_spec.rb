require 'spec_helper'

feature 'New question', %q{
    In order to get answer from community
    As an authenticated user
    I want be able to ask the question
  } do

  scenario 'Authenticated user create the question' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Sign in'

    visit questions_path
    click_on 'New question'
    fill_in 'Title', with: 'test title'
    fill_in 'Text', with: 'test text'
    click_on 'Create Question'
    expect(page).to have_content 'Question successfully created'
  end

  scenario 'Non-authenticated user create the question' do
    visit questions_path
    click_on 'New question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
