FactoryBot.define do
  factory :user do
    first_name { "Johny" }
    last_name  { "Doe" }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password { "stagecoach" }
  end
end
