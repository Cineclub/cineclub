require 'rails_helper'

feature 'User checks round movie as seen' do
  given(:user) { create(:user) }
  given(:team) { create(:team, name: 'Some team') }
  given(:round) { create(:round, user: user) }

  background do
    user.teams << team
    team.rounds << round

    sign_in(user)
  end

  scenario 'they see a success message' do
    click_link 'Teams'
    click_link 'Some team'
    click_link 'View'
    click_link 'Set movie as seen'

    expect(page).to have_content 'Screening was added successfully.'
    expect(round.screenings.count).to eq 1
  end
end
