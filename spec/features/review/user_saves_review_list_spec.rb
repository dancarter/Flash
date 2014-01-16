require 'spec_helper'

feature "User saves review list for later", %q{
  As a registered user
  I want my review lists to be saved
  So that I can finish reviewing later
} do

  #   Acceptance Criteria:
  # * When reviewing a list
  # * If I don't review the entire list, the list is saved for later
  # * I can see lists in progress on the review page
  # * After two days a review list is deleted

  context "user doesn't complete review list" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:card) { FactoryGirl.create(:card, user: user) }

    before :each do
      sign_in_as(user)
      visit review_path

      within "#all" do
        fill_in "Amount", with: '1'
        click_on "Begin"

        visit root_path
      end
    end

    it "should save the review list" do
      expect(page).to have_content('Tags: None Cards remaining: 1 Continue')
    end

    it "should be able to continue review list" do
      click_on 'Continue'
      expect(page).to have_content(card.front)
    end

  end
end
