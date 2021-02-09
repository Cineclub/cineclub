require 'rails_helper'

describe ScreeningPolicy do
  subject { described_class }

  let(:screening) { build(:screening) }

  permissions :destroy? do
    it 'grants access if user is the creator of the screening' do
      expect(subject).to permit(screening.user, screening)
    end

    it "denies access if user does not belong to the screening's round team" do
      other_user = build(:user)
      expect(subject).not_to permit(other_user, screening)
    end
  end
end
