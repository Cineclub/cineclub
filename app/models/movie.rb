class Movie < ApplicationRecord
  has_many :directions, dependent: :destroy
  has_many :directors, through: :directions

  validates :original_title, presence: true
  validates :year, presence: true
  validates :directors, presence: true
  validates :tmdb_id, uniqueness: true, allow_nil: true
  validates :imdb_id, uniqueness: true, allow_nil: true
end
