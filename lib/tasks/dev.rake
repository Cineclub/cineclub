require 'csv'

if Rails.env.development? || Rails.env.staging?
  namespace :dev do
    desc 'Seed data for development environment'
    task prime: 'db:setup' do
      CSV.foreach('lib/data/prime/directors.csv', headers: true) do |director|
        Director.find_or_create_by!(
          name: director['name'],
          country: Country.find_by(code: director['country_code'])
        )
      end

      CSV.foreach('lib/data/prime/movies.csv', headers: true) do |movie|
        director = Director.find_by!(name: movie['director_name'])
        Movie.find_or_create_by!(
          original_title: movie['original_title'],
          directors: [director]
        )
      end

      if Rails.env.development?
        Team.create(name: 'The Rest', users: [
                      User.create(
                        first_name: 'Henry',
                        last_name: 'Fonda',
                        email: 'henry@example.org',
                        password: 'filmpassword'
                      ),
                      User.create(
                        first_name: 'Lauren',
                        last_name: 'Bacall',
                        email: 'lauren@example.org',
                        password: 'filmpassword'
                      )
                    ])

        Team.create(
          name: 'The Irishmen',
          users: [
            User.create(
              first_name: 'John',
              last_name: 'Wayne',
              email: 'john@example.org',
              password: 'filmpassword'
            ),
            User.create(
              first_name: 'Maureen',
              last_name: "O'Hara",
              email: 'maureen@example.org',
              password: 'filmpassword'
            )
          ],
          rounds: [
            Round.create(user: User.last, movie: Movie.last)
          ]
        )

        Screening.create(user: User.last, round: Round.last)
      end
    end
  end
end
