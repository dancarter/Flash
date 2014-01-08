require 'spec_helper'

feature 'User reviews cards from collection', %q{
  As a registered user
  I want to study from all cards
  So that I can review my whole collection
} do

  # Acceptance Criteria:
  # * I can select to study cards from the entire collection
  # * I can specify how many cards I want to study, or else
  #   the default is 20 cards
  # * Cards are randomly selected from all cards
  # * Cards are presented for review

  before :each do
    user = FactoryGirl.create(:user)
    user.confirm!
    sign_in_as(user)
  end

  context "" do
    it "" do

    end
  end
end
