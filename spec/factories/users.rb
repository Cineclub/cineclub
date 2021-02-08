FactoryBot.define do
  sequence(:email) { |n| "user-#{n}@example.com" }

  factory :user do
    email
    first_name { 'John' }
    last_name { 'Doe' }
    password { 'password-1234' }

    trait :confirmed do
      email_confirmed_at { Time.current }
    end

    trait :with_email_confirmation_token do
      email_confirmation_token { Clearance::Token.new }
    end
  end
end
