require_relative '../acceptance_helper'

feature 'Edit comments', %q{
  In order to fix my comment
  As an authenticated user
  I want to be able to edit comments
} do

  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, user: user ) }
  given!(:comment) { create(:comment, commentable: question, user: user) }
  given!(:other_comment) { create(:comment, commentable: question, user: other_user) }

  describe 'Authenticated user' do
    background do
      sign_in user
      visit question_path(question)
    end

    scenario 'sees link to edit comment' do
      within "#comment_#{comment.id}" do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his comment with valid data', js: true do
      within "#comment_#{comment.id}" do
        click_on 'Edit'
        fill_in 'Your Comment', with: 'edited comment'
        click_on 'Update Comment'

        expect(page).to_not have_content comment.body
        expect(page).to have_content 'edited comment'
        expect(page).to_not have_selector 'textarea#comment_body'
      end
    end

    scenario 'try to edit his comment with invalid data', js: true do
      within "#comment_#{comment.id}" do
        click_on 'Edit'
        fill_in 'Your Comment', with: ''
        click_on 'Update Comment'

        expect(page).to have_content comment.body
        expect(page).to have_content "can't be blank"
        expect(page).to have_selector 'textarea#comment_body'
      end
    end

    scenario 'try to edit not-owned comment' do
      within "#comment_#{other_comment.id}" do
        expect(page).to_not have_link 'Edit'
      end
    end


  end

  scenario 'Unauthenticated user try to edit comment' do
    visit question_path(question)

    within "#comment_#{comment.id}" do
      expect(page).to_not have_link 'Edit'
    end
  end

end