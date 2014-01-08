require 'spec_helper'

feature 'User reviews cards from collection', %q{
  As a registered user
  I want to study from all cards
  So that I can review my whole collection
} do

  # Acceptance Criteria:
  # * I can select to study cards from the entire collection
  # * I can specify how many cards I want to study, or else
  #   the default is 20 cards
  # * Cards are randomly selected from all cards
  # * Cards are presented for review

  before :each do
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in_as(user)
    FactoryGirl.create(:card, user: user)
    FactoryGirl.create(:card, user: user)
    FactoryGirl.create(:card, user: user)
    FactoryGirl.create(:card, user: user)
    FactoryGirl.create(:card, user: user)
  end

  context "user starts review session with valid options" do
    it "start a review session" do
      visit review_path

      fill_in "Amount", with: '3'
      click_on "Begin"


    end
  end

  context "user starts a review session with invalid options" do
    it "gives an error if amount is more than collection size" do
      visit review_path

      fill_in "Amount", with: '13'
      click_on "Begin"

      expect(page).to have_content("Amount is higher than the number of cards in your collection.")
    end

    it "gives an error if amount is not a number" do
      visit review_path

      fill_in "Amount", with: 'Hi!'
      click_on "Begin"

      expect(page).to have_content("Amount must be a number.")
    end

    it "gives an error if amount is negative" do
      visit review_path

      fill_in "Amount", with: '-10'
      click_on "Begin"

      expect(page).to have_content("Amount must be a positive number.")
    end
  end
end
