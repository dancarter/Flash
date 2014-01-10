require 'spec_helper'

feature "User copies public tag", %q{
  As a registered user
  I want to copy a public tag
  So that I can study its cards
} do

  # Acceptance Criteria:
  # * I can add a public tag to my collection when viewing a public tag
  # * All cards under that tag are added to my collection

  context "User adds a public tag to their collection" do

    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let!(:tag) { FactoryGirl.create(:tag, user: user1, share: true) }

    before :each do
      sign_in_as(user2)
    end

    it "should add the tag to the users collection" do
      visit share_path
      click_on tag.name
      click_on "Add to Collection"

      visit tags_path
      expect(page).to have_content(tag.name)
    end

    it "should add the tag's cards to the users collection" do
      card = FactoryGirl.create(:card, user: user1)
      FactoryGirl.create(:tagging, card: card, tag: tag)
      visit share_path
      click_on tag.name
      click_on "Add to Collection"

      visit cards_path

      expect(page).to have_content(card.front)
    end

    it "should copy the tag with an accurate card count for that tag" do
      card = FactoryGirl.create(:card, user: user1)
      FactoryGirl.create(:tagging, card: card, tag: tag)
      visit share_path
      click_on tag.name
      click_on "Add to Collection"

      visit tags_path
      click_on tag.name
      expect(page).to have_content("1 card under this tag.")
    end

  end

end
