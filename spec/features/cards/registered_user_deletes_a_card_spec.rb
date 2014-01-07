require 'spec_helper'

feature "Registered user deletes a card", %q{
  As a registered user
  I want to delete a card
  So that I can remove unwanted cards
} do

  # Acceptance Criteria:
  # * I want to select a card from existing cards
  # * I can choose to delete the card
  # * I am asked to confirm the deletion
  # * If I select yes the card is deleted
  # * If I select no nothing is changed

  before :each do
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in_as(user)
    @card = FactoryGirl.create(:card, user: user)
  end

  context "delete a card" do
    it "deletes the card" do
      visit '/cards'

      click_on "#{@card.front}"

      click_on "Delete"

      expect(page).to have_content("Card was successfully deleted.")
    end
  end

end
