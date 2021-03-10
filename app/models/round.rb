class Round < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :movie, optional: true
  has_many :screenings, dependent: :destroy

  before_create :set_index_in_team

  private

  def set_index_in_team
    last_round = Round.where(team: team).order(:index_in_team).last
    self.index_in_team = last_round ? last_round.index_in_team + 1 : 1
  end
end
