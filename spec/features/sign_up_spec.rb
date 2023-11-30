require 'rails_helper'

feature 'User can sign up', %q{
  In order to be able to create questions and answers
  As an guest
  I want to be able to sign up
} do

  background { visit new_user_registration_path }

  scenario 'Non-registered user try to sign up with valid data' do
    guest = attributes_for(:user)
    fill_in 'Email', with: guest[:email]
    fill_in 'Password', with: guest[:password]
    fill_in 'Password confirmation', with: guest[:password]
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign up with invalid data' do
    guest = attributes_for(:user)
    fill_in 'Email', with: guest[:email]
    fill_in 'Password', with: guest[:password]
    fill_in 'Password confirmation', with: ''
    click_on 'Sign up'

    expect(page).to have_content 'prohibited this user from being saved'
  end
end
