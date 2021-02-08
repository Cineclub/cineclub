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
    upsert_directors
    upsert_movie
  end

  private

  def fetch_movie
    @tmdb_movie = @client.movie(@id)
  end

  def fetch_crew
    @tmdb_movie_crew = @client.movie_crew(@id)
  end

  def movie_crew_directors
    @movie_crew_directors ||= @tmdb_movie_crew.select { |e| e.job == 'Director' }
  end

  def upsert_director(tmdb_director)
    director = Director.find_or_initialize_by(tmdb_id: tmdb_director.id)

    director.assign_attributes(name: tmdb_director.name)

    director.errors.full_messages.each { |msg| error(msg) } unless director.save
    director
  end

  def upsert_directors
    @directors = movie_crew_directors.map { |tmdb_director| upsert_director(tmdb_director) }
  end

  def upsert_movie
    movie = Movie.find_or_initialize_by(tmdb_id: @tmdb_movie.id)

    movie.assign_attributes(
      original_title: @tmdb_movie.original_title,
      imdb_id: @tmdb_movie.imdb_id,
      year: Date.parse(@tmdb_movie.release_date).year,
      directors: @directors
    )

    movie.errors.full_messages.each { |msg| error(msg) } unless movie.save
    @movie = movie
  end
end
