require 'rails_helper'
 require "capybara/rspec/matchers"
 require "minitest/rails/capybara"

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
  end
end

