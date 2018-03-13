require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "I like eating"
      fill_in 'Password', :with => "short"
      click_on "Create User"
    end

    feature 'with invalid credentials' do
      scenario 'renders new user form and shows errors' do
        expect(current_path).to eq(users_path)
        expect(page).to have_content('Password is too short')
      end
    end

    feature 'with valid credentials' do
      before(:each) do
        visit new_user_url
        fill_in 'Username', :with => "I like eating"
        fill_in 'Password', :with => "biscuits"
        click_on "Create User"
      end

      scenario 'shows username on the homepage after signup' do
        expect(page).to have_content "I like eating"
      end
    end
  end
end

feature 'logging in' do
  before(:each) do
    User.create!(username: 'I like eating', password: 'biscuits')
    visit new_session_url
    fill_in 'Username', :with => "I like eating"
    fill_in 'Password', :with => "biscuits"
    click_on "Sign in"
  end

  scenario 'shows username on the homepage after login' do
    expect(page).to have_content 'I like eating'
    expect(current_path).to eq(goals_path)
  end

end

feature 'logging out' do

  scenario 'begins with a logged out state' do
    visit goals_url
    expect(page).not_to have_content("Log out")
  end

  feature 'Afer logging out' do

    before(:each) do
      User.create!(username: 'I like eating', password: 'biscuits')
      visit new_session_url
      fill_in 'Username', :with => "I like eating"
      fill_in 'Password', :with => "biscuits"
      click_on "Sign in"
      click_on "Sign out"
    end

    scenario 'doesn\'t show username on the homepage after logout' do
      expect(page).not_to have_content('I like eating')
    end
  end
end
