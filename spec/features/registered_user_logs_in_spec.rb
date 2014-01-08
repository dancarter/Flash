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

  context "user account is confirmed" do
    before :each do
      @user = FactoryGirl.create(:user)
      @user.confirm!
    end

    context "provides correct account information" do
      it "logs into the app" do
        visit '/'

        click_on 'Login'

        fill_in "Username", with: @user.username
        fill_in "Password", with: @user.password

        click_on 'Sign in'

        expect(page).to have_content("Signed in successfully")
      end
    end

    context "provides invalid account information" do
      it "displays error if password is incorrect" do
        visit '/'

        click_on 'Login'

        fill_in "Username", with: @user.username
        fill_in "Password", with: 'WR0NG'

        click_on "Sign in"

        expect(page).to have_content("Invalid login or password.")
      end

      it "displays error if username is incorrect" do
        visit '/'

        click_on 'Login'

        fill_in "Username", with: 'WR0NG'
        fill_in "Password", with: @user.password

        click_on "Sign in"

        expect(page).to have_content("Invalid login or password.")
      end
    end
  end

  context "user account isn't confirmed" do
    it "displays an error if user does not confirm email" do
      user = FactoryGirl.create(:user)

      visit '/'

      click_on 'Login'

      fill_in "Username", with: user.username
      fill_in "Password", with: user.password

      click_on 'Sign in'

      expect(page).to have_content("You have to confirm your account before continuing.")
    end
  end

end
