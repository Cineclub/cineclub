require 'rails_helper'

feature 'User sets round movie as unseen' do
  given(:team) { create(:team, name: 'Some team') }
  given(:user) { create(:user, :confirmed, teams: [team]) }
  given(:movie) { create(:movie) }
  given(:round) { create(:round, user: user, movie: movie, team: team) }

  background do
    create(:screening, user: user, round: round)
    sign_in(user)
  end

  scenario 'they see a success message' do
    click_link 'Teams'
    click_link 'Some team'
    click_link 'Round details'
    click_link 'Set movie as unseen'

    expect(page).to have_content 'Screening was removed successfully.'
    expect(round.screenings.count).to eq 0
  end
end
