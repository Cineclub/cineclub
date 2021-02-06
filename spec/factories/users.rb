FactoryBot.define do
  sequence(:email) { |n| "user-#{n}@example.com" }

  factory :user do
    email
    first_name { 'John' }
    last_name { 'Doe' }
    password { 'password-1234' }

    trait :confirmed do
      email_confirmed_at { DateTime.now }
    end
  end
end
