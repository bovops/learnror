require_relative 'acceptance_helper'

feature 'Signing up', %q{
    In order to be able ask questions
    As an user
    I want be able to sign up
  } do

  scenario 'User try to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'valid@user.com'

    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

end