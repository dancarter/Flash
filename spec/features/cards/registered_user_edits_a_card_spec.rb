require 'spec_helper'

feature "Registered user edits a card", %q{
  As a registered user
  I want to edit a card
  So that I can update it
} do

  # Acceptance Criteria:
  # * I want to select a card from existing cards
  # * The current front and back texts and asociated tags are
  #   displayed
  # * I can change the front and back text of the card
  # * I can add new tags to the card
  # * I can remove current tags from the card

  let(:user) { FactoryGirl.create(:user) }
  let!(:card) { FactoryGirl.create(:card, user: user) }

  before :each do
    sign_in_as(user)
  end

  context "edit a card with valid attributes" do
    it "updates the card" do
      visit cards_path
      click_on "#{card.front}"

      fill_in "Front", with: "2 + 1 = ?"
      fill_in "Back", with: "3"

      click_on "Update Card"

      expect(page).to have_content("Card was successfully updated.")
    end
  end

  context "edit a card with invalid attributes" do
    it "gives error when front is blank" do
      visit cards_path
      click_on "#{card.front}"

      fill_in "Front", with: ""

      click_on "Update Card"

      expect(page).to have_content("Front can't be blank")
    end

    it "gives error when back is blank" do
      visit cards_path
      click_on "#{card.front}"

      fill_in "Back", with: ""

      click_on "Update Card"

      expect(page).to have_content("Back can't be blank")
    end
  end

end
