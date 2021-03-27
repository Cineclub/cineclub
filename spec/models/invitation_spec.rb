require 'rails_helper'

RSpec.describe Invitation, type: :model do
  subject { create(:invitation) }

  describe 'associations' do
    it { should belong_to(:invitee).class_name('User') }
    it { should belong_to(:inviter).class_name('User') }
    it { should belong_to(:team) }
  end

  describe 'validations' do
    describe 'validate uniqueness of the invitee among pending invites for that team'
    context 'invitation is pending' do
      it 'does not permit foo' do
        new_invitation = Invitation.new(invitee: subject.invitee, inviter: subject.inviter, team: subject.team)
        expect(new_invitation.valid?).to be_falsey
        expect(new_invitation.errors[:invitee]).to include('has already been taken')
      end

      it 'permits bar' do
        subject.update(dismissed_at: Time.current)

        new_invitation = Invitation.new(invitee: subject.invitee, inviter: subject.inviter, team: subject.team)
        expect(new_invitation.valid?).to be_truthy
      end

      it 'allows inviting the same user to another team' do
        other_team = build(:team)
        new_invitation = Invitation.new(invitee: subject.invitee, inviter: subject.inviter, team: other_team)
        expect(new_invitation.valid?).to be_truthy
      end
    end
  end
end
