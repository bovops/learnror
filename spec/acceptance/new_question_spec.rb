require 'spec_helper'

feature 'New question', %q{
    In order to be able to ask questions
    I want be able to add new question
  } do

  scenario 'User try to add new question' do
    visit questions_path
    click_on 'New question'
    fill_in 'Title', with: 'test title'
    fill_in 'Text', with: 'test text'
    click_on 'Create Question'
    question = Question.last
    expect(current_path).to eq(question_path(question))

  end
end
