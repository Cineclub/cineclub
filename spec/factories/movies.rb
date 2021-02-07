FactoryBot.define do
  sequence(:original_title) { |n| "Movie #{n}" }

  factory :movie do
    original_title
    year { 1990 }
    directors { build_list :director, 1 }
  end
end
