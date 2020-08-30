FactoryBot.define do
  sequence(:name) { |n| "Team #{n}" }

  factory :team do
    name
  end
end
