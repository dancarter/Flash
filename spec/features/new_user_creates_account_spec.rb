require 'spec_helper'

feature "New user creates an account", %q{
  As a new user
  I want to create an account
  So that I can make flashcards
} do

  #   Acceptance Criteria:
  # * I want to create an account
  # * I must supply a username, email address, password, and password confirmation
  # * If my password and password confirmation do not match, I have to re-enter them
  # * If I enter all my details, I receive a confirmation email
  # * If I confirm my email, my account is successfully created

  context "provides account information" do
    it "creates a new account" do
      visit '/'
      click_on "Sign up"

      fill_in "Username", with: "user"
      fill_in "Email", with: "test@mail.com"
      fill_in "Password", with: "passw0rd"
      fill_in "Password confirmation", with: "passw0rd"

      click_on "Sign up"

      expect(page).to have_content("confirmation link")
    end
  end

  context "provides invalid account information" do
    it "displays errors when invalid info is given" do
      visit '/'
      click_on "Sign up"

      click_on "Sign up"

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Username can't be blank")
    end

    it "displays error if passwords don't match" do
      visit '/'
      click_on "Sign up"

      fill_in "Password", with: "passw0rd"
      fill_in "Password confirmation", with: "passw1rd"

      click_on "Sign up"

      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

end
