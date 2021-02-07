# frozen_string_literal: true

require 'rails_helper'

describe 'Screenings API', type: :request do
  let(:user) { create(:user, :confirmed) }
  let(:team) { create(:team) }
  let(:round) { create(:round, team: team) }

  describe 'POST /rounds/:round_id/screenings' do
    context 'when the user belongs to the team' do
      before do
        user.teams << team
      end

      it 'creates a new screening' do
        post round_screenings_path(round_id: round.id, as: user)
        screening = Screening.find_by(round: round, user: user)

        expect(screening).to be_present
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to round_path(round)
        expect(flash[:notice]).to eq 'Screening was added successfully.'
      end
    end

    context 'when the user does not belong to the team' do
      it 'redirects the user with an error message' do
        post round_screenings_path(round_id: round.id, as: user)
        screening = Screening.find_by(round: round, user: user)

        expect(screening).not_to be_present
        expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
      end
    end
  end

  describe 'DELETE /screenings/:id' do
    let!(:screening) { create(:screening, round: round, user: user) }

    context 'when the user belongs to the team' do
      before do
        user.teams << team
      end

      it 'deletes an existing screening' do
        delete screening_path(id: screening.id, as: user)

        expect(Screening.count).to eq 0
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to round_path(screening.round)
        expect(flash[:notice]).to eq 'Screening was removed successfully.'
      end
    end

    context 'when the user does not belong to the team' do
      it 'redirects the user with an error message' do
        delete screening_path(id: screening.id, as: user)

        expect(Screening.count).to eq 1
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
      end
    end
  end
end
