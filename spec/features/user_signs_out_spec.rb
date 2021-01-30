require 'rails_helper'

feature 'User signs out' do
  background do
    user = create(:user, email: 'johndoe@example.org', password: 'password')
    sign_in(user)
  end

  scenario 'they see the sign in button if sign out succeeded' do
    visit root_path

    click_link 'Sign out'
    expect(page).to have_content 'Sign in'
  end
end
