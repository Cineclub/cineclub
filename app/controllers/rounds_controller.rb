require 'external_urls'

class RoundsController < ApplicationController
  before_action :require_login
  before_action :set_round, only: %i[show edit update]
  before_action :set_team, only: %i[new create]

  def new
    authorize @team, :create_round?

    @round = Round.new
  end

  def create
    authorize @team, :create_round?

    @round = Round.new(round_params)
    @round.team = @team

    if @round.save
      redirect_to @round, notice: 'Round was successfully created.'
    else
      render :new
    end
  end

  def show
    @screenings = @round.screenings.includes(:user)
    @current_screening = @round.screenings.find_by(user: current_user)
  end

  def edit
    authorize @round
  end

  def update
    authorize @round

    if @round.update(round_params)
      redirect_to @round, notice: 'Round was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def round_params
    params.require(:round).permit(:user_id)
  end
end
