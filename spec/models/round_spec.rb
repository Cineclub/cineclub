require 'rails_helper'

RSpec.describe Round, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
    it { should belong_to(:movie).optional }
    it { should have_many(:screenings) }
    it { should have_many(:users) }
  end
end
