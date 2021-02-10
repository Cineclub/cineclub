module MovieHelper
  IMDB_MOVIE_BASE_URL = 'https://www.imdb.com/title'.freeze
  TMDB_MOVIE_BASE_URL = 'https://www.themoviedb.org/movie'.freeze

  def imdb_url(movie)
    return if movie.imdb_id.nil?

    "#{IMDB_MOVIE_BASE_URL}/#{movie.imdb_id}"
  end

  def tmdb_url(movie)
    "#{TMDB_MOVIE_BASE_URL}/#{movie.tmdb_id}"
  end
end
