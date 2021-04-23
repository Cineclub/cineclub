require 'rails_helper'

RSpec.describe CreateTeamAndAddUser do
  subject { CreateTeamAndAddUser.new }

  describe '#call' do
    let(:user) { create(:user) }

    it 'adds the user to a recently created team' do
      result = subject.call(user: user, team_name: 'My new team')

      expect(result).to be_successful
      expect(result.team.users).to include(user)
    end
  end
end
