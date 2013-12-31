require 'spec_helper'

feature "Registered user creates a tag", %q{
  As a registered user
  I want to create a new tag
  So that I can tag cards
} do

  # Acceptance Criteria:
  # * I want to create a new tag
  # * I must supply a name for the tag
  # * If I do not supply a name, I get an error
  # * I can optionally supply one or more tags for the card

  before :each do
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in_as(user)
  end

  context "creates a valid tag" do
    it "creates a new card" do
      visit '/'
      click_on "New Tag"

      fill_in "Name", with: "Japanese"

      click_on "Create Tag"

      expect(page).to have_content("successfully created")
    end
  end

  context "doesn't create a valid card" do
    it "gives error when front is blank" do
      visit '/'
      click_on "New Tag"

      click_on "Create Tag"

      expect(page).to have_content("Name can't be blank")
    end
  end

end
