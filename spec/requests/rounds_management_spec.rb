# frozen_string_literal: true

require 'rails_helper'

describe 'Rounds management', type: :request do
  describe 'POST teams/:id/rounds' do
    let(:team) { create(:team) }
    let(:user) { create(:user) }

    subject { post team_rounds_path(team_id: team.id, as: user) }

    before do
      user.teams << team
    end

    it "creates a round and redirects to the round's show page" do
      expect { subject }.to change(Round, :count).by(1)

      round = Round.last

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to team_round_path(team_id: round.team.id, id: round.id)
      expect(flash[:notice]).to eq 'Round created successfully.'
    end
  end
end
