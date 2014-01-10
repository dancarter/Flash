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

  let(:user) { FactoryGirl.create(:user) }
  let!(:tag) { FactoryGirl.create(:tag, user: user, share: true) }
  before :each do
    sign_in_as(user)
  end

  context "views profile" do

    it "shows user's username" do
      visit root_path
      click_on "Profile"

      expect(page).to have_content(user.username)
    end

    it "shows user's public tags" do
      visit root_path
      click_on "Profile"

      expect(page).to have_content(user.tags.first.name)
    end
  end

end
