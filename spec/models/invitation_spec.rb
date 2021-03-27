require 'rails_helper'

RSpec.describe Invitation, type: :model do
  describe 'associations' do
    subject { create(:invitation) }
    it { should belong_to(:invitee).class_name('User') }
    it { should belong_to(:inviter).class_name('User') }
    it { should belong_to(:team) }
  end

  describe 'validations' do
    describe 'validate uniqueness of the invitee among pending invites for that team' do
      let(:inviter) { create(:user) }
      let(:invitee) { create(:user) }
      let(:team) { create(:team) }
      subject { build(:invitation, inviter: inviter, invitee: invitee, team: team) }

      context 'pending invitation of `invitee` to join `team` exists' do
        before { create(:invitation, inviter: inviter, invitee: invitee, team: team) }

        it 'does not permit creating another invitation for the same user to the same team' do
          expect(subject).not_to be_valid
          expect(subject.errors[:invitee]).to include('has already been taken')
        end
      end

      context 'dismissed invitation of `invitee` to join `team` exists' do
        before { create(:invitation, inviter: inviter, invitee: invitee, team: team, dismissed_at: Time.current) }

        it 'permits creating another invitation for the same user to the same team' do
          expect(subject).to be_valid
        end
      end

      context 'inviting a user different than `invitee`' do
        let(:another_invitee) { create(:user) }
        subject { build(:invitation, inviter: inviter, invitee: another_invitee, team: team) }

        it 'allows inviting the same user to another team' do
          expect(subject).to be_valid
        end
      end
    end
  end
end
