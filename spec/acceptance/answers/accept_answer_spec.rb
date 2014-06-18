require_relative '../acceptance_helper'

feature 'Accept answer', %q{
  In order to illustrate best answer
  As an question's author
  I want to accept answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user ) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    describe "Questions's author" do

      scenario 'accept answer', js: true do
        expect(current_path).to eq question_path(question)
        within "#answer-#{answer.id}" do
          click_on 'Best Answer'
        end

        expect(page).to have_css "#answer-#{answer.id}.accepted"
      end

    end

    describe 'Other authenticated user' do
      background do
        sign_out
        sign_in( create(:user) )
        visit question_path(question)
      end

      scenario 'try to accept answer' do
        within "#answer-#{answer.id}" do
          expect(page).to_not have_link 'Best Answer'
        end
      end

    end

  end

  describe 'Guest' do
    background do
      visit question_path(question)
    end

    scenario 'try to accept answer' do
      expect(page).to_not have_link 'Best Answer'
    end
  end

end