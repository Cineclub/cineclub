require 'rails_helper'

feature 'User leaves one of his teams' do
  given(:user) { create(:user) }

  background do
    user.teams << create(:team, name: 'Some team')
    sign_in(user)
  end

  scenario 'they see a success message' do
    click_link 'Teams'
    click_link 'Some team'
    click_link 'Leave'

    expect(page).to have_content 'Team was successfully abandoned.'
    expect(user.teams.count).to eq 0
  end
end
