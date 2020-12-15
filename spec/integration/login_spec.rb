require 'rails_helper'

RSpec.describe 'Log in', type: :feature do
  let(:user) { User.create!(name: 'solo', email: 'solo@gmail.com', password: 'abc1234789') }
  let(:friend) { User.create!(name: 'john', email: 'john@gmail.com', password: 'abc1236789') }

  scenario 'sign in' do
    visit root_path
    # Fil the fields
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('solo')
  end


  scenario 'Send friend request' do
    visit root_path

    # Fil the fields
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')

    click_on 'All users'
    expect(page).to have_content('All users')
  end
end
