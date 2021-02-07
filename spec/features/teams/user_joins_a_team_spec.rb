require 'rails_helper'

feature 'User joins an existing team' do
  given(:user) { create(:user, :confirmed) }

  background do
    sign_in(user)
    create(:team, name: 'Some team')
  end

  scenario 'they see a success message' do
    click_link 'Teams'
    click_link 'Some team'
    click_link 'Join'

    expect(page).to have_content 'Team was successfully joined.'
    expect(user.teams.count).to eq 1
  end
end
