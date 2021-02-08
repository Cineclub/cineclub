require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should have_many(:directors) }
  end

  describe 'validations' do
    subject { build(:movie) }
    it { should validate_presence_of(:directors) }
    it { should validate_presence_of(:original_title) }
    it { should validate_presence_of(:year) }
    it { should validate_uniqueness_of(:tmdb_id) }
    it { should validate_uniqueness_of(:imdb_id).allow_nil }
  end
end
