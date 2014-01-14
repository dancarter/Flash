require 'spec_helper'

feature 'User reviews cards from collection', %q{
  As a registered user
  I want to study from all cards
  So that I can review my whole collection
} do

  # Acceptance Criteria:
  # * I can select to study cards from the entire collection
  # * I can specify how many cards I want to study
  # * Cards are randomly selected from all cards
  # * Cards are presented for review

  let(:user) { FactoryGirl.create(:user) }
  let!(:card) { FactoryGirl.create(:card, user: user) }

  before :each do
    sign_in_as(user)
  end

  context "user starts review session with valid options" do
    it "starts a review session" do
      visit review_path

      within "#all" do
        fill_in "Amount", with: '1'
        click_on "Begin"
      end

      expect(page).to have_content(card.front)
      click_on "Answer"
      click_on "Finish"
      expect(page).to have_content('Review Complete!')
    end
  end

  context "user starts a review session with invalid options" do
    it "gives an error if amount is more than collection size" do
      visit review_path

      within "#all" do
        fill_in "Amount", with: '13'
        click_on "Begin"
      end

      expect(page).to have_content("Amount can't be greater than available cards")
    end

    it "gives an error if amount is not a number" do
      visit review_path

      within "#all" do
        fill_in "Amount", with: 'Hi!'
        click_on "Begin"
      end

      expect(page).to have_content("Amount is not a number")
    end

    it "gives an error if amount is negative" do
      visit review_path

      within "#all" do
        fill_in "Amount", with: '-10'
        click_on "Begin"
      end

      expect(page).to have_content("Amount must be greater than or equal to 1")
    end

    it "gives an error if amount is zero" do
      visit review_path

      within "#all" do
        fill_in "Amount", with: '0'
        click_on "Begin"
      end

      expect(page).to have_content("Amount must be greater than or equal to 1")
    end
  end
end
