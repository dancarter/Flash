require 'spec_helper'

feature "Registered user deletes a tag", %q{
  As a registered user
  I want to delete a tag
  So that I can remove unwanted tags
} do

  # Acceptance Criteria:
  # * I want to select a tag from existing tags
  # * I can choose to delete the tag
  # * I am asked to confirm the deletion
  # * If I select yes the tag is deleted
  # * If I select no nothing is changed

  let(:user) { FactoryGirl.create(:user) }
  let!(:tag) { FactoryGirl.create(:tag, user: user) }

  before :each do
    sign_in_as(user)
  end

  context "delete a tag" do
    it "deletes the tag" do
      visit tags_path

      click_on "#{tag.name}"
      click_on "Delete"

      expect(page).to have_content("Tag was successfully deleted.")
    end

    it "removes the tag from the user's collection" do
      visit tags_path

      click_on "#{tag.name}"
      click_on "Delete"

      visit tags_path

      expect(page).to_not have_content(tag.name)
    end
  end

end
