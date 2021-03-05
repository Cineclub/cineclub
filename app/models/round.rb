class Round < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :movie, optional: true
  has_many :screenings, dependent: :destroy

  def number_in_team
    team.rounds.order(created_at: :asc).where('created_at < ?', created_at).count + 1
  end
end
