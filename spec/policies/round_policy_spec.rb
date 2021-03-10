require 'rails_helper'

describe RoundPolicy do
  subject { described_class }

  let(:round) { create(:round) }
  let(:user) { create(:user) }

  permissions :create_screening? do
    it "grants access if user belongs to the round's team" do
      Membership.create(user: user, team: round.team)

      expect(subject).to permit(user, round)
    end

    it "denies access if user does not belong to the round's team" do
      expect(subject).not_to permit(user, round)
    end
  end

  permissions :update_movie? do
    context 'user has turn in round' do
      let(:round) { create(:round, user: user) }

      it 'denies access if the round has screenings' do
        round.screenings.create(user: user)

        expect(subject).not_to permit(user, round)
      end

      it "grants access if the round hasn't any screenings" do
        expect(subject).to permit(user, round)
      end
    end

    context 'user does not have turn in round' do
      it "denies access even if the round hasn't any screenings" do
        expect(subject).not_to permit(user, round)
      end
    end
  end

  permissions :update? do
    context 'user belongs to team' do
      before { Membership.create(user: user, team: round.team) }

      it 'grants access' do
        expect(subject).to permit(user, round)
      end
    end

    context 'user does not belong to team' do
      it 'denies access' do
        expect(subject).not_to permit(user, round)
      end
    end
  end
end
