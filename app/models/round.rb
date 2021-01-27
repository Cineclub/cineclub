class Round < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :movie, optional: true
  has_many :screenings
end
