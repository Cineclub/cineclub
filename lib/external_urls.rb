module ExternalUrls
  IMDB_MOVIE_BASE_URL = 'https://www.imdb.com/title'.freeze
  TMDB_MOVIE_BASE_URL = 'https://www.themoviedb.org/movie'.freeze

  def imdb_movie_url(id)
    return if id.nil?

    "#{IMDB_MOVIE_BASE_URL}/#{id}"
  end

  def tmdb_movie_url(id)
    return if id.nil?

    "#{TMDB_MOVIE_BASE_URL}/#{id}"
  end

  module_function :imdb_movie_url, :tmdb_movie_url
end
