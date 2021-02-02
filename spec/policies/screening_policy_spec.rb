require 'rails_helper'

describe ScreeningPolicy do
  subject { described_class }

  permissions :create? do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:round) { create(:round, team: team) }
    let(:screening) { create(:screening, user: user, round: round) }

    it "grants access if user belongs to the screening's round team" do
      team.users << user

      expect(subject).to permit(user, screening)
    end

    it "denies access if user does not belong to the screening's round team" do
      expect(subject).not_to permit(user, screening)
    end
  end
end
