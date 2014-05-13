require_relative 'acceptance_helper'

feature 'Signing in', %q{
    In order to be able ask questions
    As an user
    I want be able to sign in
  } do

  scenario 'Existing user try to log in' do
    user = create(:user)
    sign_in(user)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Existing user try to log in with invalid password' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'invalidpassword'
    click_on 'Sign in'
    expect(page).to have_content 'Invalid email or password.'
  end

  scenario 'Non-existing user try to log in' do
    visit new_user_session_path
    fill_in 'Email', with: 'invalid@user.com'
    fill_in 'Password', with: 'invalidpassword'
    click_on 'Sign in'
    expect(page).to have_content 'Invalid email or password.'
  end
end