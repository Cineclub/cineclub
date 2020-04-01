require 'rails_helper'

RSpec.describe Direction, type: :model do
  describe 'associations' do
    it { should belong_to(:director) }
    it { should belong_to(:movie) }
  end
end
