require 'rails_helper'

RSpec.describe 'user log in' do
  it 'has a form to log in' do
    visit '/'
    click_on 'Log In'
    expect(current_path).to eq("/login")
  end

  it 'can log a user in' do
    user = User.create!(name: "User1", email: "user1@user1.com", password: "user1", password_confirmation: "user1")
    visit '/login'
    fill_in 'Email', with: "user1@user1.com"
    fill_in 'Password', with: "user1"
    click_on 'Log In'

    expect(current_path).to eq("/dashboard")
  end

  it 'has an error for a bad email' do
    user = User.create!(name: "User1", email: "user1@user1.com", password: "user1", password_confirmation: "user1")
    visit '/login'
    fill_in 'Email', with: "user2@user2.com"
    fill_in 'Password', with: "user1"
    click_on 'Log In'

    expect(current_path).to eq("/login")
    expect(page).to have_content("Email Not Found")
  end

  it 'has an error for bad password' do
    user = User.create!(name: "User1", email: "user1@user1.com", password: "user1", password_confirmation: "user1")
    visit '/login'
    fill_in 'Email', with: "user1@user1.com"
    fill_in 'Password', with: "user2"
    click_on 'Log In'

    expect(current_path).to eq("/login")
    expect(page).to have_content("INVALID PASSWORD")
  end
end
