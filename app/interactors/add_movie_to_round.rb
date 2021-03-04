require 'hanami/interactor'

class AddMovieToRound
  include Hanami::Interactor

  expose :movie, :round

  def initialize(import_tmdb_movie_interactor: ImportTmdbMovie.new)
    @import_tmdb_movie_interactor = import_tmdb_movie_interactor
  end

  def call(round:, tmdb_movie_id:)
    @round = round
    @tmdb_movie_id = tmdb_movie_id

    fetch_movie
    update_round
  end

  private

  def fetch_movie
    found_movie = Movie.find_by(tmdb_id: @tmdb_movie_id)

    @movie =
      if found_movie.present?
        found_movie
      else
        import_movie_result = import_tmdb_movie
        fail! unless import_movie_result.successful?

        import_movie_result.movie
      end
  end

  def update_round
    @round.movie = @movie
    @round.errors.full_messages.each { |msg| error(msg) } unless @round.save
  end

  def import_tmdb_movie
    @import_tmdb_movie_interactor.call(tmdb_movie_id: @tmdb_movie_id)
  end
end
