class Round < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :movie, optional: true
  has_many :screenings, dependent: :destroy
  has_many :users, through: :team
end
