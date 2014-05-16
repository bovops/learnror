# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "My Question's title"
    body "My Question's body"
    user ""
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
