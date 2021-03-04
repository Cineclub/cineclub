require 'external_urls'

class RoundsController < ApplicationController
  before_action :require_login
  before_action :set_round, only: %i[show edit update]
  before_action :set_team, only: [:create]

  def create
    authorize @team, :create_round?

    round = Round.new(team: @team, user: current_user)

    if round.save
      redirect_to round_path(round), notice: 'Round created successfully.'
    else
      flash[:alert] = "Couldn't create round."
      redirect_to @team
    end
  end

  def show
    @screenings = @round.screenings.includes(:user)
    @current_screening = @round.screenings.find_by(user: current_user)
  end

  def edit; end

  def update; end

  private

  def set_round
    @round = Round.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
