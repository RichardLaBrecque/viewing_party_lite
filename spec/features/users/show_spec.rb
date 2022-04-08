require 'rails_helper'

RSpec.describe 'User Show Page' do
  before (:each) do
    @user_1 = User.create!(name: 'Ron', email: 'Test1@test.com', password: "test", password_confirmation: "test")
    @user_2 = User.create!(name: 'dave', email: 'Test2@test.com', password: "test", password_confirmation: "test")
    visit '/login'
    fill_in 'Email', with: "Test1@test.com"
    fill_in 'Password', with: "test"
    click_on 'Log In'
  end
    it 'will show a user show page' do
        visit("/dashboard")
        expect(page).to have_content("Ron's Dashboard")
    end
    describe 'viewing parties' do
        before :each do
            @vp1 = ViewingParty.create!(user: @user_1, movie_id: 143, date_time: DateTime.now, duration: 150)
            @vp2 = ViewingParty.create!(user: @user_1, movie_id: 144, date_time: Date.yesterday, duration: 400)
            @uvp = UserViewingParty.create!(user: @user_2, viewing_party: @vp1)
        end
        it 'will show upcoming viewing parties', :vcr do
            visit("/dashboard")
            within "#0" do
                within ".host" do

                    expect(page).to have_content("Ron (self)")
                end
            end
        end
    end
    describe 'invited users' do
         before :each do
            @vp1 = ViewingParty.create!(user: @user_1, movie_id: 143, date_time: DateTime.now, duration: 300)
            @uvp1 = UserViewingParty.create!(user: @user_2, viewing_party: @vp1)
            @user_3 = User.create(name: 'User 3', email: 'user3@yahoo.com', password: "test", password_confirmation: "test")
            @uvp_2 = UserViewingParty.create(user: @user_3, viewing_party: @vp1)
        end
        it 'will show guests on a tile', :vcr do
            visit("/dashboard")
            within "#0" do
                within ".invited" do
                    expect(page).to have_content('dave')
                    expect(page).to have_content('User 3')
                end
            end
        end
        it 'will show the name of the host on the tile', :vcr do
            visit(user_path(@user_2))
            within "#0" do
                within ".host" do
                    expect(page).to have_content('Ron')
                end
            end
        end
        it 'will have links to the guest pages', :vcr do
            visit("/dashboard")
            within "#0" do
                within ".invited" do
                    expect(page).to have_link('dave')
                    expect(page).to have_link('User 3')
                    click_link('dave')
                    expect(current_path).to eq(user_path(@user_2))
                end
            end
        end
    end
end
