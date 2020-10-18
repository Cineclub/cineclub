# frozen_string_literal: true

class RoundsController < ApplicationController
  before_action :require_login
  before_action :set_round, only: [:show]

  def create
    round = Round.new(
      team_id: params[:team_id],
      user: current_user
    )

    if round.save
      redirect_to team_round_path(team_id: round.team_id, id: round), notice: 'Round created successfully.'
    else
      redirect_to @team, notice: "Couldn't create round."
    end
  end

  def show; end

  private

  def set_round
    @round = Round.find(params[:id])
  end
end
