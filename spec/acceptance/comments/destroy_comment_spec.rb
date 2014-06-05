require_relative '../acceptance_helper'

feature 'Delete comment', %q{
  In order to fix mistake
  As an author of comment
  I'd like to destroy my comment
} do

  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given!(:comment) { create(:comment, commentable: answer, user: user) }
  given!(:other_comment) { create(:comment, commentable: answer, user: other_user) }

  scenario 'Unauthenticated user try to destroy comment' do
    visit question_path(question)

    within "#comment-#{comment.id}" do
      expect(page).to_not have_link 'Delete'
    end
  end

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Sees link to destroy comment' do
      within "#comment-#{comment.id}" do
        expect(page).to have_link 'Delete'
      end
    end

    scenario 'try to destroy his comment', js: true do
      within "#comment-#{comment.id}" do
        click_on 'Delete'
      end

      expect(current_path).to eq question_path(question)
      expect(page).to_not have_selector "#comment-#{comment.id}"
    end

    scenario 'try to destroy not-owned comment', js: true do
      within "#comment-#{other_comment.id}" do
        expect(page).to_not have_link 'Delete'
      end
    end

  end


end