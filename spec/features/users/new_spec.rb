require 'rails_helper'

RSpec.describe 'creating a new user' do
  it 'has a form to create a new user' do
    visit '/register'
    fill_in 'Name', with: "Nametest"
    fill_in 'Email', with: "emailtest.test.com"
    fill_in 'Password', with: "test"
    fill_in 'password_confirmation', with: "test"
    click_on "Save"
    user = User.last
    expect(current_path).to eq("/dashboard")

  end
  it 'has a give an error for bad user creation' do
    visit '/register'
    fill_in 'Name', with: "Nametest"
    fill_in 'Email', with: "emailtest.test.com"
    fill_in 'Password', with: "test"
    fill_in 'password_confirmation', with: "test2"
    click_on "Save"

    expect(current_path).to eq("/register")
    expect(page).to have_content("Password confirmation doesn't match Password")

  end
end
