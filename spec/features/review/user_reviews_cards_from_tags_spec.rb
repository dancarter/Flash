require 'spec_helper'

feature "User reviews cards from tags", %q{
  As a registered user
  I want to select tags to review
  So that I can study cards
} do

  #   Acceptance Criteria:
  # * I can select one of more tags
  # * I can specify how many cards I want to study
  # * Cards are randomly selected from each tag evenly
  # * Cards are presented for review

  let(:user) { FactoryGirl.create(:user) }
  let!(:tag1) { FactoryGirl.create(:tag, user: user) }
  let!(:tag2) { FactoryGirl.create(:tag, user: user) }
  let!(:card1) { FactoryGirl.create(:card, user: user) }
  let!(:card2) { FactoryGirl.create(:card, user: user) }
  let!(:tagging1) { FactoryGirl.create(:tagging, tag: tag1, card: card1)}
  let!(:tagging2) { FactoryGirl.create(:tagging, tag: tag2, card: card2)}

  before :each do
    sign_in_as(user)
  end

  context "user starts review session with valid options" do
    it "starts a review session with only the cards from selected tag" do
      visit review_path

      within "#tags" do
        select tag1.name, from: 'review_list_tag_ids'
        fill_in "Amount", with: '1'
        click_on "Begin"
      end

      expect(page).to have_content(card1.front)
      expect(page).to have_content(card1.back)
      expect(page).to_not have_content(card2.front)
      expect(page).to_not have_content(card2.back)
      click_on "Complete"
      expect(page).to have_content('Review Complete!')
    end
  end

  context "user starts a review session with invalid options" do
    it "gives an error if amount is more than collection size" do
      visit review_path
      click_on 'By Tags'

      within "#tags" do
        select tag1.name, from: 'review_list_tag_ids'
        fill_in "Amount", with: '13'
        click_on "Begin"
      end

      expect(page).to have_content("Amount can't be greater than available cards")
    end

    it "gives an error if amount is not a number" do
      visit review_path
      click_on 'By Tags'

      within "#tags" do
        select tag1.name, from: 'review_list_tag_ids'
        fill_in "Amount", with: 'Hi!'
        click_on "Begin"
      end

      expect(page).to have_content("Amount is not a number")
    end

    it "gives an error if amount is negative" do
      visit review_path
      click_on 'By Tags'

      within "#tags" do
        select tag1.name, from: 'review_list_tag_ids'
        fill_in "Amount", with: '-10'
        click_on "Begin"
      end

      expect(page).to have_content("Amount must be greater than or equal to 1")
    end

    it "gives an error if amount is zero" do
      visit review_path
      click_on 'By Tags'

      within "#tags" do
        select tag1.name, from: 'review_list_tag_ids'
        fill_in "Amount", with: '0'
        click_on "Begin"
      end

      expect(page).to have_content("Amount must be greater than or equal to 1")
    end
  end
end
