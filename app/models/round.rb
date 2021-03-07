class Round < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :movie, optional: true
  has_many :screenings, dependent: :destroy

  def index
    team.rounds.where('id < ?', id).count + 1
  end
end
