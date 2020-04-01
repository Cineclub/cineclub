class Director < ApplicationRecord
  belongs_to :country
  has_many :directions
  has_many :movies, through: :directions
  validates :name, presence: true
end
