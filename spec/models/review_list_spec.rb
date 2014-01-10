require 'spec_helper'

describe ReviewList do
  it { should validate_presence_of :user}

  it { should have_many(:review_list_tags).dependent(:destroy) }
  it { should have_many(:review_list_cards).dependent(:destroy) }
  it { should have_many(:cards).through(:review_list_cards) }
  it { should have_many(:tags).through(:review_list_tags) }
  it { should belong_to(:user) }

  describe "#set_cards" do
    it "should set an amount of random cards for a review list" do
      user = FactoryGirl.create(:user)
      card = FactoryGirl.create(:card, user: user)
      review_list = FactoryGirl.create(:review_list, user: user)
      FactoryGirl.create(:review_list_card, card: card, review_list: review_list)

      ReviewList.set_cards(review_list, user)
      expect(review_list.cards).to include(card)
    end
  end

end
