class Movie < ApplicationRecord
  has_many :directions, dependent: :destroy
  has_many :directors, through: :directions

  validates :original_title, presence: true
  validates :year, presence: true
  validates :directors, presence: true
end
