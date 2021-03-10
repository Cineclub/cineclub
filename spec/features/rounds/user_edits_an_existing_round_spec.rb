require 'rails_helper'

feature 'User edits an existing round' do
  given(:user) { create(:user, :confirmed) }
  given(:another_user) { create(:user, first_name: 'Jane', last_name: 'Doe') }
  given(:team) { create(:team, name: 'Some team') }
  given(:round) { create(:round, user: user) }

  background do
    team.users << [user, another_user]
    team.rounds << round

    sign_in(user)
  end

  scenario 'they see a success message' do
    click_link 'Teams'
    click_link 'Some team'
    click_link 'Round details'
    click_link 'Edit round'

    select 'Jane Doe', from: 'User'
    click_button 'Save'

    expect(page).to have_content 'Round was successfully updated.'
    expect(round.reload.user.id).to eq another_user.id
  end
end
