require_relative 'acceptance_helper'

feature 'Edit answer', %q{
  In order to fix mistake
  As an author of answer
  I'd like to be able to edit my answer
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end

  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees link to Edit' do
      expect(page).to have_link 'Edit'
    end

    scenario 'try to edit answer with valid data', js: true do
      click_on 'Edit'

      within '.answers' do
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'try to edit answer with invalid data', js: true do
      click_on 'Edit'

      within '.answers' do
        fill_in 'Answer', with: ''
        click_on 'Save'

        expect(page).to have_content answer.body
        expect(page).to have_selector 'textarea'
        expect(page).to have_content "can't be blank"
      end
    end

  end
end
