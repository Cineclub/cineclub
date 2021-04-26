require 'rails_helper'

feature 'User accepts a pending invitation' do
  given(:user) { create(:user, :confirmed) }
  given!(:invitation) { create(:invitation, invitee: user) }

  background do
    sign_in(user)
  end

  scenario 'they are redirected to the dashboard with a success message' do
    click_button 'Accept'

    expect(page).to have_content 'Invitation accepted successfully.'
    expect(user.member_of?(invitation.team)).to eq true
  end
end
