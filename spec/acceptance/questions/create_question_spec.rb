require_relative '../acceptance_helper'

feature 'New question', %q{
    In order to get answer from community
    As an authenticated user
    I want be able to ask the question
  } do

  scenario 'Authenticated user create the question', js: true do
    user = create(:user)
    sign_in(user)

    visit questions_path
    click_on 'Ask a Question'
    fill_in 'Title', with: 'test title'
    fill_in 'Body', with: 'test text'
    click_on 'Post Your Question'
    expect(page).to have_content 'Question successfully created'
    expect(current_path).to eq '/questions/1'
  end

  scenario 'Non-authenticated user create the question' do
    visit questions_path
    click_on 'Ask a Question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
