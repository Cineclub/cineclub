require 'rails_helper'

feature 'User signs up' do
  scenario 'they are created after signing up' do
    visit sign_up_path

    fill_in 'Email', with: 'user@example.org'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Password', with: 'password'
    click_button 'Sign up'

    expect(User.count).to eq 1
  end

  scenario 'they are not logged in if sign up fails' do
    visit sign_up_path

    fill_in 'Email', with: 'wrong-email-address'
    click_button 'Sign up'

    expect(page).to have_content 'Sign up'
  end
end
