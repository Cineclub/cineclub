require 'csv'

if Rails.env.development? || Rails.env.staging?
  namespace :dev do
    desc "Seed data for development environment"
    task prime: "db:setup" do
      if Rails.env.development?
        User.create(
          first_name: "John",
          last_name: "Wayne",
          email: "john@example.org",
          password: "stagecoach"
        )
      end

      CSV.foreach('lib/data/prime/directors.csv', headers: true) do |director|
        Director.find_or_create_by!(
          name: director['name'],
          country: Country.find_by(code: director['country_code'])
        )
      end

      CSV.foreach('lib/data/prime/movies.csv', headers: true) do |movie|
        Movie.find_or_create_by!(
          original_title: movie['original_title'],
          directors: [Director.find_by(name: movie['director_name'])]
        )
      end
    end
  end
end
