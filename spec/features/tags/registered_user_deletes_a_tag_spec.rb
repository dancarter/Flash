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

  before :each do
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in_as(user)
    @tag = FactoryGirl.create(:tag, user: user)
  end

  context "delete a tag" do
    it "deletes the tag" do
      visit '/tags'

      click_on "#{@tag.name}"
      click_on "Delete"

      expect(page).to have_content("Tag was successfully deleted.")
    end
  end

end
