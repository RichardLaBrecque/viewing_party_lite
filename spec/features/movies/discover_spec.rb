require 'rails_helper'

RSpec.describe 'the discover movies page' do
  before (:each) do
    @u1 = User.create!(name: 'Mr 1', email: 'Test1@test.com', password: "test", password_confirmation: "test")
    visit '/login'
    fill_in 'Email', with: "Test1@test.com"
    fill_in 'Password', with: "test"
    click_on 'Log In'
  end
  it 'has a button for top rated movies' do
    visit "/discover"
    expect(page).to have_button("Top Rated Movies")
    expect(page).to have_button("Search by Title")
  end
end
