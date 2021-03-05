require 'rails_helper'

RSpec.describe Round, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
    it { should belong_to(:movie).optional }
    it { should have_many(:screenings) }
  end

  describe '#number_in_team' do
    let(:team) { create(:team) }

    it "returns the round's position in a team's context according to its creation date" do
      oldest_round = create(:round, team: team, created_at: 2.days.ago)
      in_between_round = create(:round, team: team, created_at: 1.day.ago)
      newest_round = create(:round, team: team)

      expect(oldest_round.number_in_team).to eq 1
      expect(in_between_round.number_in_team).to eq 2
      expect(newest_round.number_in_team).to eq 3
    end
  end
end
