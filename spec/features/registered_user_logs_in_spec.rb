require 'spec_helper'

feature "Registered user logs in", %q{
  As a registered user
  I want to log in
  So that I can use the app
} do

  # Acceptance Criteria:
  # * I must supply my username and password
  # * If my username or password are incorrect, I must re-enter them
  # * If my username and password are correct I am logged into the site

  before :each do
    user = FactoryGirl.create(:user)
    user.confirm!
  end

  context "provides correct account information" do
    it "logs into the app" do
      visit '/'
      click_on "Login"

      fill_in "Username", with: "TheUser"
      fill_in "Password", with: "passw0rd"

      click_on "Sign in"

      expect(page).to have_content("Signed in successfully")
    end
  end

  context "provides invalid account information" do

    it "displays error if password is incorrect" do
      visit '/'
      click_on "Login"

      fill_in "Username", with: "TheUser"
      fill_in "Password", with: "WRONG"

      click_on "Sign in"

      expect(page).to have_content("Invalid login or password.")
    end

    it "displays error if username is incorrect" do
      visit '/'
      click_on "Login"

      fill_in "Username", with: "WRONG"
      fill_in "Password", with: "passw0rd"

      click_on "Sign in"

      expect(page).to have_content("Invalid login or password.")
    end
  end

end
