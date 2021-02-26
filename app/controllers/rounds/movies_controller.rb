module Rounds
  class MoviesController < ApplicationController
    before_action :require_login
    before_action :set_round, only: [:edit, :update]

    def edit
      authorize @round, :edit_movie?
    end

    def update
      authorize @round, :update_movie?

      result = AddMovieToRound.new.call(round: @round, tmdb_movie_id: params[:round][:tmdb_id])

      if result.successful?
        redirect_to round_path(@round), notice: 'Round updated successfully.'
      else
        flash[:alert] = "Couldn't update round."
        redirect_to edit_round_path(@round)
      end
    end

    private

    def set_round
      @round = Round.find(params[:round_id])
    end
  end
end
