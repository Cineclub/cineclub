require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:country).optional }
    it { should have_many(:memberships) }
    it { should have_many(:rounds) }
    it { should have_many(:teams) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name)}
  end
end
