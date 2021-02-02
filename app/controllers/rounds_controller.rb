class RoundsController < ApplicationController
  before_action :require_login
  before_action :set_round, only: [:show]
  before_action :set_team, only: [:create]

  def create
    round = Round.new(team: @team, user: current_user)

    authorize round

    if round.save
      redirect_to round_path(round), notice: 'Round created successfully.'
    else
      redirect_to @team, notice: "Couldn't create round."
    end
  end

  def show
    @screenings = @round.screenings.includes(:user)
    @current_screening = @round.screenings.find_by(user: current_user)
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
