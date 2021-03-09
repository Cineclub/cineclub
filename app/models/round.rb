class Round < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :movie, optional: true
  has_many :screenings, dependent: :destroy

  before_create :set_index_in_team

  def set_index_in_team
    self.index_in_team = next_index_in_team
  end

  private

  def next_index_in_team
    (Round.where(team: team).order(:index_in_team).last&.index_in_team.to_i + 1) || 1
  end
end
