class Movie < ApplicationRecord
  has_many :directions, dependent: :destroy
  has_many :directors, through: :directions

  validates :original_title, presence: true
  validates :directors, presence: true

  def directors_names
    directors.map(&:name).join(', ')
  end
end
