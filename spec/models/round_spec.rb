require 'rails_helper'

RSpec.describe Round, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
    it { should belong_to(:movie).optional }
    it { should have_many(:screenings) }
  end

  describe '#index' do
    let(:team) { create(:team) }
    let(:another_team) { create(:team) }

    it "returns the round's position in a team's context according to its creation date" do
      first_round = create(:round, team: team)
      second_round = create(:round, team: team)
      third_round = create(:round, team: team)
      another_teams_round = create(:round, team: another_team)

      expect(first_round.index_in_team).to eq 1
      expect(second_round.index_in_team).to eq 2
      expect(third_round.index_in_team).to eq 3
      expect(another_teams_round.index_in_team).to eq 1
    end
  end
end
