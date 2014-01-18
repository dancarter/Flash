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

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in_as(user)
  end

  context "user imports cards from a valid file" do
    it "should add the cards to the users collection" do
      visit new_card_import_path

      attach_file('card_import_file', Rails.root.join('spec/files/valid.csv'))
      click_on 'Import'

      expect(page).to have_content("Imported cards successfully")
    end
  end

  context "user imports cards from an invalid file" do
    it "should add the cards to the users collection" do
      visit new_card_import_path

      attach_file('card_import_file', Rails.root.join('spec/files/invalid.csv'))
      click_on 'Import'

      expect(page).to have_content("Row 2: Front can't be blank")
      expect(page).to have_content("Row 3: Back can't be blank")
    end

    it "should give an error if file is not a CSV" do
      visit new_card_import_path

      attach_file('card_import_file', Rails.root.join('spec/files/notcsv.txt'))
      click_on 'Import'

      expect(page).to have_content("Unknown file type")
    end
  end
end
