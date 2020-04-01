require "rails_helper"

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should have_many(:directors) }
  end

  describe 'validations' do
    it { should validate_presence_of(:directors)}
    it { should validate_presence_of(:original_title)}
  end
end
