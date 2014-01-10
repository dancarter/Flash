require 'spec_helper'

feature "Registered user edits a tag", %q{
  As a registered user
  I want to edit a tag
  So that I can update it
} do

  # Acceptance Criteria:
  # * I want to select a tag from existing tags
  # * The current front and back texts and asociated tags are
  #   displayed
  # * I can change the front and back text of the tag
  # * I can add new tags to the tag
  # * I can remove current tags from the tag

  let(:user) { FactoryGirl.create(:user) }
  let!(:tag) { FactoryGirl.create(:tag, user: user) }

  before :each do
    sign_in_as(user)
  end

  context "edit a tag with valid attributes" do
    it "updates the tag" do
      visit tags_path
      click_on "#{tag.name}"

      fill_in "Name", with: "Python"

      click_on "Update Tag"

      expect(page).to have_content("Tag was successfully updated.")
    end
  end

  context "edit a tag with invalid attributes" do
    it "gives error when name is blank" do
      visit tags_path
      click_on "#{tag.name}"

      fill_in "Name", with: ""

      click_on "Update Tag"

      expect(page).to have_content("Name can't be blank")
    end
  end

end
