require 'spec_helper'

feature "User views public tags", %q{
  As a registered user
  I want to search public tags
  So that I can see other users' cards
} do

  #   Acceptance Criteria:
  # * I can see a list of public tags
  # * I can search to see tags with specific names
  # * If there are tags with names matching my search they are shown
  # * Otherwise, a no tags found message is shown
  # * I can click on a tag to see the cards it contains

  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let!(:tag1) { FactoryGirl.create(:tag, user: user1, share: true) }
  let!(:tag2) { FactoryGirl.create(:tag, user: user1, share: true) }

  before :each do
    sign_in_as(user2)
  end

  context "user views public tags" do

    it "should list public tags" do
      visit share_path

      expect(page).to have_content(tag1.name)
      expect(page).to have_content(tag2.name)
    end

    it "should not list private tags" do
      tag3 = FactoryGirl.create(:tag, user: user1)

      visit share_path

      expect(page).to_not have_content(tag3.name)
    end

  end

  context "user searches for public tag" do

    it "should show tag with matching name" do
      visit share_path
      fill_in "Search by tag name", with: tag1.name
      click_on "Search"

      expect(page).to have_content(tag1.name)
    end

    it "should not show tag without matching name" do
      visit share_path
      fill_in "Search by tag name", with: tag1.name
      click_on "Search"

      expect(page).to_not have_content(tag2.name)
    end

  end

  context "user clicks public tag to view cards" do

    it "should show the cards under chosen tag" do
      card = FactoryGirl.create(:card, user: user1)
      FactoryGirl.create(:tagging, card: card, tag: tag1)
      visit share_path
      click_on tag1.name

      expect(page).to have_content(card.front)
      expect(page).to have_content(card.back)
    end

  end

end
