require_relative '../acceptance_helper'

feature 'Delete answer', %q{
  In order to fix mistake
  As an author of answer
  I'd like to destroy my answer
} do

  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:other_answer) { create(:answer, question: question, user: other_user) }

  scenario 'Unauthenticated user try to destroy answer' do
    visit question_path(question)

    within "#answer-#{answer.id}" do
      expect(page).to_not have_link 'Delete'
    end
  end

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Sees link to destroy answer' do
      within "#answer-#{answer.id}" do
        expect(page).to have_link 'Delete'
      end
    end

    scenario 'try to destroy his answer', js: true do
      within "#answer-#{answer.id}" do
        click_on 'Delete'
        page.driver.browser.switch_to.alert.accept
      end

      expect(current_path).to eq question_path(question)
      expect(page).to_not have_selector "#answer-#{answer.id}"
    end

    scenario 'try to destroy not-owned answer', js: true do
      within "#answer-#{other_answer.id}" do
        expect(page).to_not have_link 'Delete'
      end
    end

  end


end