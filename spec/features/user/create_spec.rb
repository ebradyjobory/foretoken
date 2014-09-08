require 'spec_helper'

describe "User login" do 

	it "displays an error when user leavs username empty" do
    visit '/'
    fill_in :profile_name, with: ""
    click_button "Log In"
    expect(page).to have_content('Invalid profile name/password')
	end

	it "displays an error when user leavs password empty" do
    visit '/'
    fill_in :password, with: ""
    click_button "Log In"
    expect(page).to have_content('Invalid profile name/password')
	end
end

describe "Create new User" do

	def create_user(options={})
		options[:first_name]            ||= "Essam"
		options[:last_name]             ||= "Joubori"
		options[:profile_name]          ||= "ejoubori"
		options[:email]                 ||= "ej@gmail.com"
		options[:password]              ||= "password"
		options[:password_confirmation] ||= "password"

		visit '/'
		click_button 'Sign Up'
		expect(page).to have_content('Sign up')

		fill_in :first_name,  with: options[:first_name]
		fill_in :last_name,  with: options[:last_name]
		fill_in :profile_name,  with: options[:profile_name]
		fill_in :email,  with: options[:email]
		fill_in :password,  with: options[:password]
		fill_in :password_confirmation,  with: options[:password_confirmation]

		click_button "Sign Up"
	end
	
	it "displays an error when user forget first name" do
		create_user first_name: ""
		expect(page).to have_content("error")

	end 



end