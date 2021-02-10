require 'hanami/interactor'

class AddMovieToRound
  include Hanami::Interactor

  attr_reader :round, :tmdb_id

  def initialize(round:, tmdb_id:)
    @round = round
    @tmdb_id = tmdb_id
  end

  def call
    movie = Movie.find_by(tmdb_id: tmdb_id)
    movie = imported_movie if movie.blank?

    movie.errors.full_messages.each { |msg| error(msg) } unless round.update(movie: movie)
  end

  private

  def imported_movie
    result = ImportTmdbMovie.new.call(tmdb_movie_id: tmdb_id)
    fail! if result.failure?

    result.movie
  end
end
