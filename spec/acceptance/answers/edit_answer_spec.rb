require_relative '../acceptance_helper'

feature 'Edit answer', %q{
  In order to fix mistake
  As an author of answer
  I'd like to be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:other_answer) { create(:answer, question: question, user: other_user) }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees link to Edit' do
      within "#answer_#{answer.id}" do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit answer with valid data', js: true do
      within "#answer_#{answer.id}" do
        click_on 'Edit'
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea#answer_body'
      end
    end

    scenario 'try to edit answer with invalid data', js: true do
      within "#answer_#{answer.id}" do
        click_on 'Edit'
        fill_in 'Answer', with: ''
        click_on 'Save'

        expect(page).to have_content answer.body
        expect(page).to have_selector 'textarea'
        expect(page).to have_content "can't be blank"
      end
    end

    scenario 'try to edit not-owned answer' do
      within "#answer_#{other_answer.id}" do
        expect(page).to_not have_link 'Edit'
      end
    end

  end
end
