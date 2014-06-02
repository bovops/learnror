require_relative '../acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's author
  A'd like to be able to attach files
} do

  given!(:user) { create(:user) }
  given(:question) { create(:question, user: user)}

  background do
    sign_in user
    visit question_path(question)
  end

  scenario 'create answer with attachment', js: true do
    within 'form#new_answer' do
      fill_in 'Your Answer', with: 'My test answer'
      click_on 'Add a file'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Post Your Answer'
    end

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end

  end

end