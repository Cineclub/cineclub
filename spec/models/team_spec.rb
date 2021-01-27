require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'associations' do
    it { should have_many(:memberships) }
    it { should have_many(:rounds) }
    it { should have_many(:users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it do
      should validate_length_of(:name)
        .is_at_least(5)
        .is_at_most(40)
    end
  end
end
