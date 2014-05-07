# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password 'password'
  end

  factory :invalid_user, class: 'User' do
    email 'invalid_email'
    password 'password'
  end
end
