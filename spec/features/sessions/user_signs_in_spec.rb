require 'rails_helper'

feature 'User signs in' do
  background do
    create(:user, email: 'johndoe@example.org', password: 'password')
  end

  scenario 'they see the sign out button if sign in succeeded' do
    visit sign_in_path

    fill_in 'Email', with: 'johndoe@example.org'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content 'Sign out'
  end

  scenario 'they see an error message if sign in failed' do
    visit sign_in_path

    fill_in 'Email', with: 'johndoe@example.org'
    fill_in 'Password', with: 'wrong password'
    click_button 'Sign in'

    expect(page).to have_content 'Bad email or password.'
    expect(page).not_to have_content 'Sign out'
  end
end
