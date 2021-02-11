require 'hanami/interactor'

class AddMovieToRound
  include Hanami::Interactor

  def initialize(import_service: ImportTmdbMovie.new)
    @import_service = import_service
  end

  def call(round:, tmdb_id:)
    @round = round
    @tmdb_id = tmdb_id

    movie = Movie.find_by(tmdb_id: @tmdb_id)
    movie = imported_movie if movie.blank?

    movie.errors.full_messages.each { |msg| error(msg) } unless @round.update(movie: movie)
  end

  private

  def imported_movie
    result = @import_service.call(tmdb_movie_id: @tmdb_id)
    fail! if result.failure?

    result.movie
  end
end
