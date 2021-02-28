# frozen_string_literal: true

require 'rails_helper'

describe 'Rounds API', type: :request do
  describe 'POST /teams/:id/rounds' do
    let(:team) { create(:team) }
    let(:user) { create(:user, :confirmed) }

    context 'when the user belongs to the team' do
      before do
        user.teams << team
      end

      context 'when team and user are valid' do
        it "creates a round for the authenticated user and redirects to the round's show page" do
          post team_rounds_path(team_id: team.id, as: user)

          round = Round.find_by(user: user, team: team)

          expect(round).to be_present
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to round_path(round)
          expect(flash[:notice]).to eq 'Round created successfully.'
        end
      end

      context "when the round can't be created" do
        before { allow_any_instance_of(Round).to receive(:save).and_return(false) }

        it "redirects to the team's page with an error message" do
          post team_rounds_path(team_id: team.id, as: user)

          round = Round.find_by(user: user, team: team)

          expect(round).to be_nil
          expect(response).to redirect_to team_path(id: team.id)
          expect(flash[:alert]).to eq "Couldn't create round."
        end
      end
    end

    context 'when the user does not belong to the team' do
      it 'redirects the user with an error message' do
        post team_rounds_path(team_id: team.id, as: user)

        round = Round.find_by(user: user, team: team)

        expect(round).not_to be_present
        expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
      end
    end
  end

  describe 'PUT /rounds/:id' do
    let(:user) { create(:user, :confirmed) }
    let(:round) { create(:round, user: user, movie: nil) }
    let(:movie) { create(:movie) }
    before { round.team.users << user }

    context 'when the tmdb_id matches an existing movie' do
      it "updates the round's movie" do
        put round_movie_path(round.id, params: { movie: { tmdb_id: movie.tmdb_id } }, as: user)

        expect(round.reload.movie).to eq movie
        expect(flash[:notice]).to eq 'Round updated successfully.'
      end
    end
  end
end
