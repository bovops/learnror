require_relative '../acceptance_helper'

feature 'Add tags to question', %q{
  As an question's author
  A'd like to be able to set tags
} do

  given(:user) { create(:user) }

  background do
    sign_in user
    visit questions_path
  end

  scenario 'User adds file when asks question', js: true do
    click_on 'Ask a Question'
    fill_in 'Title', with: 'test title'
    fill_in 'Body', with: 'test text'
    fill_in 'Tag list', with: 'tag1'
    click_on 'Post Your Question'
    within '.tags-box' do
      expect(page).to have_content 'tag1'
    end
  end

end