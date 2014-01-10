require 'spec_helper'

feature "User removes tag from all tagged cards", %q{
  As a registered user
  I want to remove a specific tag from all cards
  So that it will no longer be tagging any cards
} do

  # Acceptance Criteria:
  # * When viewing a tag
  # * I can click a button to remove the rag from all cards
  # * When I click the button

  before :each do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    sign_in_as(@user)
    @tag = FactoryGirl.create(:tag, user: @user)
  end

  context "user removes tag from all cards" do

    it "should remove tag from all cards" do
      visit tags_path
      click_on @tag.name
      click_on "Remove from Cards"

      expect(page).to have_content("Tag successfully removed from all cards.")
    end

    it "should no longer associate any cards with the tag" do
      card = FactoryGirl.create(:card, user: @user)
      FactoryGirl.create(:tagging, card: card, tag: @tag)
      visit tags_path
      click_on @tag.name
      click_on "Remove from Cards"

      expect(page).to have_content("0 cards under this tag.")
    end

  end

end
