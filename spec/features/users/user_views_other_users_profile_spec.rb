require 'spec_helper'

feature "User views another user's profile", %q{
  As a registered user
  I want to see other users' profiles
  So that I can see their public information and tags
} do

  # Acceptance Criteria:
  # * I can click a username from the share page to view that user's profile
  # * I can see a list of their public tags
  # * If I click a tag I can see the cards under that tag

  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let!(:tag) { FactoryGirl.create(:tag, user: user1, share: true) }

  before :each do
    sign_in_as(user2)
  end

  context "user visits another users profile" do
    it "should show the other user's username" do
      visit user_path(user1)

      expect(page).to have_content(user1.username)
    end

    it "should show the other user's public tags" do
      visit user_path(user1)

      expect(page).to have_content(tag.name)
    end

    it "should link to any public tags cards" do
      card = FactoryGirl.create( :card, user: user1 )
      FactoryGirl.create(:tagging, card: card, tag: tag)

      visit user_path(user1)
      click_on tag.name

      expect(page).to have_content(card.front)
      expect(page).to have_content(card.back)
    end

  end

end
