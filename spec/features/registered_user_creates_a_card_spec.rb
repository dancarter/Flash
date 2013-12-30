require 'spec_helper'

feature "Registered user creates a card", %q{
  As a registered user
  I want to create a new card
  So that I can study it later
} do

  # Acceptance Criteria:
  # * I want to create a new card
  # * I must supply text for the front and back of the card
  # * If I do not supply a front and back, I get an error
  # * I can optionally supply one or more tags for the card

  before :each do
    user = FactoryGirl.create(:user)
    user.confirm!
    login_as(user)
  end

  context "creates a valid card" do
    it "creates a new card" do
      vists '/'
      click_on "Create card"

      fill_in "Front", with: "1 + 1 = ?"
      fill_in "Back", with: "2"

      click_on "Save card"

      expect(page).to have_content("successfully saved")
    end
  end

  context "doesn't create an invalid card" do
    it "gives error when front is blank" do
      vists '/'
      click_on "Create card"

      fill_in "Back", with: "2"

      click_on "Save card"

      expect(page).to have_content("Front can't be blank")
    end

    it "gives error when back is blank" do
      vists '/'
      click_on "Create card"

      fill_in "Front", with: "1 + 1 = ?"

      click_on "Save card"

      expect(page).to have_content("Back can't be blank")
    end
  end

end
