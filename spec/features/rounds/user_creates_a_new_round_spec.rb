require 'rails_helper'

feature 'User triggers the creation of a new round' do
  given(:user) { create(:user, :confirmed) }

  background do
    user.teams << create(:team, name: 'Some team')
    sign_in(user)
  end

  scenario 'they see a success message' do
    click_link 'Teams'
    click_link 'Some team'
    click_link 'Create New Round'

    expect(page).to have_content 'Round created successfully.'
    expect(page).to have_content 'No movie has been set yet.'
  end
end
