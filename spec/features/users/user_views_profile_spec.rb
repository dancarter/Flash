require 'spec_helper'

feature "User views profile", %q{
  As a registered user
  I want to see my profile
  So that I can see my account info
} do

  # Acceptance Criteria:
  # * I can go to my profile
  # * I can see my username and email
  # * I can see all my tags

  before :each do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    sign_in_as(@user)
    FactoryGirl.create(:tag, user: @user)
  end

  context "views profile" do
    it "shows user's email" do
      visit '/'
      click_on "Profile"

      expect(page).to have_content(@user.email)
    end

    it "shows user's username" do
      visit '/'
      click_on "Profile"

      expect(page).to have_content(@user.username)
    end

    it "shows user's tags" do
      visit '/'
      click_on "Profile"

      expect(page).to have_content(@user.tags.first.name)
    end
  end

end
