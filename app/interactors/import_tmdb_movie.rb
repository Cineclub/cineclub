require 'hanami/interactor'
require 'tmdb/client'

class ImportTmdbMovie
  include Hanami::Interactor

  expose :movie, :directors

  def initialize(client: Tmdb::Client.new)
    @client = client
  end

  def call(tmdb_movie_id:)
    @id = tmdb_movie_id

    fetch_movie
    fetch_crew
    import_movie
  end

  private

  def fetch_movie
    @tmdb_movie = @client.movie(@id)
  end

  def fetch_crew
    @tmdb_movie_crew = @client.movie_crew(@id)
  end

  def movie_directors
    @movie_directors ||= @tmdb_movie_crew.select { |e| e.job == 'Director' }
  end

  def import_movie
    @directors =
      movie_directors.map do |tmdb_director|
        director = Director.find_or_initialize_by(tmdb_id: tmdb_director.id)

        director.name = tmdb_director.name

        unless director.save
          director.errors.full_messages.each { |msg| error(msg) }
        end
        director
      end

    @movie =
      begin
        movie = Movie.find_or_initialize_by(tmdb_id: @tmdb_movie.id)

        movie.original_title = @tmdb_movie.original_title
        movie.imdb_id = @tmdb_movie.imdb_id
        movie.year = Date.parse(@tmdb_movie.release_date).year
        movie.directors = @directors

        unless movie.save
          movie.errors.full_messages.each { |msg| error(msg) }
        end
        movie
      end
  end
end
