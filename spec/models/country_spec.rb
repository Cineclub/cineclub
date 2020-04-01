require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'validations' do
    subject { Country.new(code: 'PT', name: 'Portugal') }
    it { should validate_uniqueness_of(:code)}
    it { should validate_uniqueness_of(:name)}
    it { should validate_presence_of(:code)}
    it { should validate_presence_of(:name)}
  end
end
