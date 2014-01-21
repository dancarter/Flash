require 'spec_helper'

feature "User filters cards by tag", %q{
    As a registered user
    I want to filter my card list by tag
    So that I can find cards for specific tags quickly
} do

  # Acceptance Criteria
  # * I can choose a tag when viewing my card list
  # * Cards not under that tag are filtered out
  # * If no tag is chosen, all cards are listed

  let(:user) { FactoryGirl.create(:user) }
  let!(:tag) { FactoryGirl.create(:tag, user: user) }
  let!(:card1) { FactoryGirl.create(:card, user: user) }
  let!(:card2) { FactoryGirl.create(:card, user: user) }
  let!(:tagging) { FactoryGirl.create(:tagging, card: card1, tag: tag) }

  before :each do
    sign_in_as(user)
  end

  context "User selects no tag" do

    it "displays all cards" do
      visit cards_path

      expect(page).to have_content(card1.front)
      expect(page).to have_content(card2.front)
    end

  end

  context "User selects a tag" do

    it "should only show cards for that tag" do
      card2 = FactoryGirl.create(:card, user: user)

      visit cards_path

      select tag.name, from: 'q_tags_id_eq'
      click_on 'Filter'

      expect(page).to have_content(card1.front)
      expect(page).to_not have_content(card2.front)
    end

  end

end
