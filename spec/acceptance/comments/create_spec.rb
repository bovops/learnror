require_relative '../acceptance_helper'

feature 'Сomments', %q{
  In order to comment
  As an authenticated user
  I want to be able to create comments
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user ) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in user
      visit question_path(question)
    end

    describe "Answer's comment" do

      scenario 'sees form to create comment' do
        within "#answer_#{answer.id}" do
          expect(page).to have_selector 'textarea#comment_body'
        end
      end

      scenario 'try to create with valid data', js: true do
        within "#answer_#{answer.id}" do
          fill_in 'Your Comment', with: 'My test comment'
          click_on 'Post Your Comment'
        end

        expect(current_path).to eq question_path(question)
        within "#answer_#{answer.id} .comments" do
          expect(page).to have_content 'My test comment'
        end
        within "#answer_#{answer.id} form#new_comment" do
          expect(page).to_not have_content 'My test comment'
        end
      end

      scenario 'try to create with invalid data', js: true do
        within "#answer_#{answer.id}" do
          fill_in 'Your Comment', with: ''
          click_on 'Post Your Comment'
        end

        expect(current_path).to eq question_path(question)
        within "#answer_#{answer.id} form#new_comment" do
          expect(page).to have_content "can't be blank"
        end
      end
    end

    describe "Question's comment" do

      scenario 'sees form to create comment' do
        within ".question" do
          expect(page).to have_selector 'textarea#comment_body'
        end
      end

      scenario 'try to create with valid data', js: true do
        within '.question' do
          fill_in 'Your Comment', with: 'My test comment'
          click_on 'Post Your Comment'
        end

        expect(current_path).to eq question_path(question)
        within '.question .comments' do
          expect(page).to have_content 'My test comment'
        end
        within '.question form#new_comment' do
          expect(page).to_not have_content 'My test comment'
        end
      end

      scenario 'try to create with invalid data', js: true do
        within '.question' do
          fill_in 'Your Comment', with: ''
          click_on 'Post Your Comment'
        end

        expect(current_path).to eq question_path(question)
        within ".question form#new_comment" do
          expect(page).to have_content "can't be blank"
        end
      end
    end



  end

  scenario "Unauthenticated user try to create comment" do
    visit question_path(question)

    expect(page).to_not have_selector 'textarea#comment_body'
  end


end

