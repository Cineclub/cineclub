class Movie < ApplicationRecord
  IMDB_MOVIE_BASE_URL = 'https://www.imdb.com/title'.freeze
  TMDB_MOVIE_BASE_URL = 'https://www.themoviedb.org/movie'.freeze

  has_many :directions, dependent: :destroy
  has_many :directors, through: :directions

  validates :original_title, presence: true
  validates :year, presence: true
  validates :directors, presence: true
  validates :tmdb_id, presence: true, uniqueness: true
  validates :imdb_id, uniqueness: true, allow_nil: true

  def imdb_url
    return if imdb_id.nil?

    "#{IMDB_MOVIE_BASE_URL}/#{imdb_id}"
  end

  def tmdb_url
    "#{TMDB_MOVIE_BASE_URL}/#{tmdb_id}"
  end
end
