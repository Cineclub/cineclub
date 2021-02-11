module MovieHelper
  IMDB_MOVIE_BASE_URL = 'https://www.imdb.com/title'.freeze
  TMDB_MOVIE_BASE_URL = 'https://www.themoviedb.org/movie'.freeze

  def imdb_url(imdb_id)
    "#{IMDB_MOVIE_BASE_URL}/#{imdb_id}" if imdb_id.present?
  end

  def tmdb_url(tmdb_id)
    "#{TMDB_MOVIE_BASE_URL}/#{tmdb_id}" if tmdb_id.present?
  end
end
