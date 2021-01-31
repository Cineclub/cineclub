class Movie < ApplicationRecord
  has_many :directions, dependent: :destroy
  has_many :directors, through: :directions

  validates :original_title, presence: true
  validates :directors, presence: true

  def self.import_from_tmdb(tmdb_id)
    api_key = ENV['TMDB_API_KEY']

    url = "https://api.themoviedb.org/3/movie/#{tmdb_id}?&append_to_response=credits&api_key=#{api_key}"
    response = HTTParty.get(url)

    # Directors are part of the credits -> crew data structure
    # Check: https://www.themoviedb.org/talk/53ba24bac3a3685eba0067ea
    directors_data = response['credits']['crew'].select { |entry| entry['job'] == 'Director' }

    directors = directors_data.map do |d|
      Director.find_or_create_by!(
        name: d['name'],
        country: Country.first # TODO: fetch country
      )
    end

    Movie.create!(original_title: response['original_title'], directors: directors)
  end
end
