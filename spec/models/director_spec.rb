require 'rails_helper'

RSpec.describe Director, type: :model do
  describe 'associations' do
    it { should have_many(:movies) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
