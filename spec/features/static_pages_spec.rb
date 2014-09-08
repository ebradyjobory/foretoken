require 'spec_helper'

describe "Pages" do

  describe "Home page" do

    it "should redirect end user to login page when visit the main page" do
      visit '/access'
      expect(page).to have_content('Please log in')
    end
    it "should show login page when visit root" do
      visit '/'
      expect(page).to have_content('Login')
    end

    it "displays an error when no profile name entered" do
    visit '/'
    fill_in :profile_name, with: ""
    click_button "Log In"
    expect(page).to have_content('Invalid profile name/password')
	end

	it "displays an error when no profile name entered" do
    visit 'new_project_path'
    fill_in :name, with: ""
    click_button "Create New Project"
    expect(page).to have_content('error')
	end

  end
end

