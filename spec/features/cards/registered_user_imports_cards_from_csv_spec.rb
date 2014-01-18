require 'spec_helper'

feature "Registered user imports cards from a file", %q{
  As a registered user
  I want to import cards from a file
  So that I can easily add new cards
} do

  # Acceptance Criteria
  # * I can choose a file to import from
  # * If the file is valid, the cards are added to my collection
  # * If the cards are invalid, I get an error

  context "user imports cards from a valid file" do
    it "should add the cards to the users collection" do
      visit #card import path

      attach_file('attach_file_id', Rails.root.join('spec/files/valid.csv'))
      click_on 'Import'

      expect(page).to have_content("Cards successfully imported")
    end
  end

    context "user imports cards from an invalid file" do
    it "should add the cards to the users collection" do
      visit #card import path

      attach_file('attach_file_id', Rails.root.join('spec/files/invalid.csv'))
      click_on 'Import'

      expect(page).to have_content("Row 2: Front can't be blank")
      expect(page).to have_content("Row 2: Back can't be blank")
    end
  end
end
