FactoryBot.define do
  factory :director do
    name { 'David Lynch' }
    sequence(:tmdb_id)
  end
end
