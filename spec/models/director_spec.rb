require 'rails_helper'

RSpec.describe Director, type: :model do
  describe 'associations' do
    it { should have_many(:movies) }
  end

  describe 'validations' do
    subject { build(:director) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:tmdb_id) }
    it { should validate_uniqueness_of(:imdb_id).allow_nil }
  end
end
