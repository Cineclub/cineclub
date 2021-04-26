require 'rails_helper'

feature 'User invites another user for a team' do
  given(:user) { create(:user, :confirmed) }
  given(:another_user) { create(:user, :confirmed) }

  background do
    user.teams << create(:team, name: 'Some team')
    sign_in(user)
  end

  scenario 'they see a success message' do
    click_link 'Teams'
    click_link 'Some team'
    fill_in 'invitee_email', with: another_user.email
    click_button 'Invite'

    expect(page).to have_content 'User was successfully invited to team.'
    expect(another_user.received_pending_invitations.count).to eq 1
  end
end
