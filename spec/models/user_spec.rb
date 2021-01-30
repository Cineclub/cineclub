require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:country).optional }
    it { should have_many(:memberships) }
    it { should have_many(:rounds) }
    it { should have_many(:teams) }
    it { should have_many(:screenings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
  end

  describe '#member_of?' do
    subject do
      User.create(
        email: 'example@example.com',
        password: 'password',
        first_name: 'User'
      )
    end
    let(:team) { Team.new(name: 'Example Team') }

    context 'when user belongs to team' do
      before { subject.teams << team }
      it 'returns true' do
        expect(subject.member_of?(team)).to be_truthy
      end
    end

    context 'when user does not belong to team' do
      it 'returns false' do
        expect(subject.member_of?(team)).to be_falsy
      end
    end
  end
end
