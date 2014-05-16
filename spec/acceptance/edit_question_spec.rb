require_relative 'acceptance_helper'

feature 'Edit question', %q{
  In order to fix mistake
  As an author of question
  I'd like to be able to edit my question
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_question) { create(:question, user: other_user) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)
    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end

  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to edit his question' do
      within '.question' do
        expect(page).to have_content 'Edit'
      end
    end

    scenario 'does not sees link to edit other question' do
      visit question_path(other_question)
      within '.question' do
        expect(page).to_not have_content 'Edit'
      end
    end

    scenario 'try to edit his question with valid data', js: true do
      within '.question' do
        click_on 'Edit'
        fill_in 'Title', with: "edited question's title"
        fill_in 'Body', with: "edited question's body"
        click_on 'Update Question'

        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content "edited question's title"
        expect(page).to have_content "edited question's body"
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'try to edit question with invalid data', js: true do
      within '.question' do
        click_on 'Edit'
        fill_in 'Body', with: ''
        click_on 'Update Question'
        expect(page).to have_content question.body
        expect(page).to have_content "can't be blank"
        expect(page).to have_selector 'textarea'
      end
    end
  end



end