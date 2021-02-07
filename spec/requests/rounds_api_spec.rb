# frozen_string_literal: true

require 'rails_helper'

describe 'Rounds API', type: :request do
  describe 'POST /teams/:id/rounds' do
    let(:team) { create(:team) }
    let(:user) { create(:user, :confirmed) }

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
        expect(flash[:notice]).to eq "Couldn't create round."
      end
    end
  end
end
