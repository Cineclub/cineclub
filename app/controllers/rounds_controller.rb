class RoundsController < ApplicationController
  before_action :require_login
  before_action :set_round, only: [:show]
  before_action :set_team, only: [:create]

  def create
    round = Round.new(team: @team, user: current_user)

    if round.save
      redirect_to team_round_path(team_id: round.team_id, id: round), notice: 'Round created successfully.'
    else
      redirect_to @team, notice: "Couldn't create round."
    end
  end

  def show
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
