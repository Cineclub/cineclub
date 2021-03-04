require 'rails_helper'

RSpec.describe Screening, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:round) }
  end

  describe 'validations' do
    subject { build(:screening, user: build(:user), round: build(:round)) }
    it { should validate_uniqueness_of(:user).scoped_to(:round_id) }
  end
end
