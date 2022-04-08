require 'rails_helper'

RSpec.describe 'the movie results page' do
  before (:each) do
    @user_1 = User.create!(name: 'Ron', email: 'Test1@test.com', password: "test", password_confirmation: "test")
    @user_2 = User.create!(name: 'dave', email: 'Test2@test.com', password: "test", password_confirmation: "test")
    visit '/login'
    fill_in 'Email', with: "Test1@test.com"
    fill_in 'Password', with: "test"
    click_on 'Log In'
  end

  it 'lists the top 40 movies', :vcr do
    visit "/discover"
    click_button "Top Rated Movies"
    expect(current_path).to eq("/users/#{@user_1.id}/movies")
    expect(page).to have_content("Top Movies")
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to have_content("Dilwale Dulhania Le Jayenge")
    expect(page).to have_content("Violet Evergarden: The Movie")

  end

  it 'can search for movies', :vcr do
    visit "/discover"
    fill_in :title, with: "Avengers"
    click_button "Search by Title"
    expect(page).to have_content("The Avengers")
    expect(page).to have_content("Avengers: Endgame")
    expect(page).to have_content("Avengers Grimm")
    expect(page).to have_content("Ultimate Avengers 2")
  end
end
