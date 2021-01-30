FactoryBot.define do
  factory :director do
    country { Country.find_or_create_by!(code: 'US', name: 'United States') }
    name { 'David Lynch' }
  end
end
