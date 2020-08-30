class RoundsController < ApplicationController
  before_action :require_login
  before_action :set_team
  before_action :set_round, only: [:show]

  def create
    round = Round.new(
      team: @team,
      user: current_user
    )

    if round.save
      redirect_to team_round_path(team_id: @team, id: round), notice: "Round created successfully."
    else
      redirect_to @team, notice: "Couldn't create round."
    end
  end

  def show
  end

  private

  def set_team
    @team = current_user.teams.find(params[:team_id])
  end

  def set_round
    @round = @team.rounds.find(params[:id])
  end
end
