require 'rails_helper'

describe TeamPolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:team) { build(:team) }

  permissions :create_round? do
    let(:user) { build(:user) }

    it 'grants access if user belongs to the team' do
      Membership.create(user: user, team: team)

      expect(subject).to permit(user, team)
    end

    it "denies access if user does not belong to the round's team" do
      expect(subject).not_to permit(user, team)
    end
  end
end
