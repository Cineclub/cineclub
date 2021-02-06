require 'rails_helper'

feature 'User creates a team' do
  background do
    user = create(:user, :confirmed)
    sign_in(user)
  end

  scenario 'they are redirected to the new team\'s page' do
    click_link 'Add a team'

    fill_in 'Name', with: 'Team 1'
    click_button 'Save Team'

    expect(page).to have_content 'Team 1'
    expect(page).to have_content 'Team was successfully created.'
  end
end
