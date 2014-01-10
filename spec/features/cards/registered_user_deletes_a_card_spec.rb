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

  let(:user) { FactoryGirl.create(:user) }
  let!(:card) { FactoryGirl.create(:card, user: user) }


  before :each do
    sign_in_as(user)
  end

  context "delete a card" do
    it "deletes the card" do
      visit cards_path

      click_on "#{card.front}"
      click_on "Delete"

      expect(page).to have_content("Card was successfully deleted.")
    end

    it "removes the card from the user's collection" do
      visit cards_path

      click_on "#{card.front}"
      click_on "Delete"

      visit cards_path

      expect(page).to_not have_content(card.front)
    end
  end

end
