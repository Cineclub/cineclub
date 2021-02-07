class Director < ApplicationRecord
  has_many :directions, dependent: :destroy
  has_many :movies, through: :directions
  validates :name, presence: true
  validates :tmdb_id, uniqueness: true, allow_nil: true
  validates :imdb_id, uniqueness: true, allow_nil: true
end
