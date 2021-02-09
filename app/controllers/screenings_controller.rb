class ScreeningsController < ApplicationController
  before_action :require_login
  before_action :set_round, only: [:create]
  before_action :set_screening, only: [:destroy]

  def create
    authorize @round, :create_screening?

    screening = Screening.new(round: @round, user: current_user)

    if screening.save
      redirect_to round_path(@round), notice: 'Screening was added successfully.'
    else
      redirect_to round_path(@round), notice: "Couldn't add screening."
    end
  end

  def destroy
    authorize @screening

    @screening.destroy # TODO: we're not doing anything with the result, so don't if was successful

    redirect_to round_path(@screening.round), notice: 'Screening was removed successfully.'
  end

  private

  def set_round
    @round = Round.find(params[:round_id])
  end

  def set_screening
    @screening = Screening.find(params[:id])
  end
end
