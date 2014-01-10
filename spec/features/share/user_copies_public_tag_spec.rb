require 'spec_helper'

feature "User copies public tag", %q{
  As a registered user
  I want to copy a public tag
  So that I can study its cards
} do

  # Acceptance Criteria:
  # * I can add a public tag to my collection when viewing a public tag
  # * If I already have a tag with the same name, the tag is added with a suffix added
  # * The tag and all cards belonging to it are added to my collection

  context "User adds a public tag to their collection" do

    before :each do
      @user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      @user1.confirm!
      user2.confirm!
      @tag = FactoryGirl.create(:tag, user: @user1, share: true)
      sign_in_as(user2)
    end

    it "should add the tag to the users collection" do
      visit share_path
      click_on @tag.name
      click_on "Add to Collection"

      visit tags_path

      expect(page).to have_content(@tag.name)
    end

    it "should add the tag's cards to the users collection" do
      card = FactoryGirl.create(:card, user: @user1)
      FactoryGirl.create(:tagging, card: card, tag: @tag)
      visit share_path
      click_on @tag.name
      click_on "Add to Collection"

      visit cards_path

      expect(page).to have_content(card.front)
    end

  end

  context "User adds a tag sharing a name with tag already in collection" do

    it "should add the tag to collection with a suffix added to the name" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      user1.confirm!
      user2.confirm!
      tag1 = FactoryGirl.create(:tag, user: user1, share: true)
      tag2 = FactoryGirl.create(:tag, name: tag1.name, user: user2)
      sign_in_as(user2)

      visit share_path
      click_on tag1.name
      click_on "Add to Collection"

      visit tags_path

      expect(page).to have_content("#{tag1.name}(1)")
    end

  end

end
