require 'rails_helper'

describe RoundPolicy do
  subject { described_class }

  permissions :create? do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:round) { create(:round, team: team) }

    it "grants access if user belongs to the round's team" do
      team.users << user

      expect(subject).to permit(user, round)
    end

    it "denies access if user does not belong to the round's team" do
      expect(subject).not_to permit(user, round)
    end
  end
end
