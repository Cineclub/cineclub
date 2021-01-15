class ScreeningsController < ApplicationController
  before_action :require_login
  before_action :set_round, only: [:create]
  before_action :set_screening, only: [:destroy]

  def create
    screening = Screening.new(round: @round, user: current_user)

    if screening.save
      redirect_to round_path(@round), notice: 'Screening was added successfully.'
    else
      redirect_to round_path(@round), notice: "Couldn't add screening."
    end
  end

  def destroy
    screening_round = @screening.round
    @screening.destroy

    redirect_to round_path(screening_round)
  end

  private

  def set_round
    @round = Round.find(params[:round_id])
  end

  def set_screening
    @screening = Screening.find(params[:id])
  end
end
