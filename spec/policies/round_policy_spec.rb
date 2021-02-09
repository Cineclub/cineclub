require 'rails_helper'

describe RoundPolicy do
  subject { described_class }

  let(:round) { build(:round) }
  let(:user) { build(:user) }

  permissions :create_screening? do
    it "grants access if user belongs to the round's team" do
      Membership.create(user: user, team: round.team)

      expect(subject).to permit(user, round)
    end

    it "denies access if user does not belong to the round's team" do
      expect(subject).not_to permit(user, round)
    end
  end
end
