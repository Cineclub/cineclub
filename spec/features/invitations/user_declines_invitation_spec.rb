require 'rails_helper'

feature 'User declines a pending invitation' do
  given(:user) { create(:user, :confirmed) }
  given!(:invitation) { create(:invitation, invitee: user) }

  background do
    sign_in(user)
  end

  scenario 'they are redirected to the dashboard with a success message' do
    click_button 'Decline'

    expect(page).to have_content 'Invitation declined successfully.'
    expect(user.member_of?(invitation.team)).to eq false
  end
end
