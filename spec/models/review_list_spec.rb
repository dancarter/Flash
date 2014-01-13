require 'spec_helper'

describe ReviewList do
  it { should validate_presence_of :user }
  it { should validate_presence_of :amount }

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

  describe "#all_cards" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:card) { FactoryGirl.create(:card, user: user) }
    let!(:review_list) { FactoryGirl.create(:review_list, user: user) }

    it "should return all cards available to a review list" do
      all_cards = ReviewList.all_cards(review_list, user)
      expect(all_cards).to include(card)
    end

    it "should return only cards available to tags specified" do
      tag = FactoryGirl.create(:tag, user: user)
      card2 = FactoryGirl.create(:card, user: user)
      FactoryGirl.create(:tagging, card: card, tag: tag)
      review_list.tags << tag

      all_cards = ReviewList.all_cards(review_list, user)
      expect(all_cards).to include(card)
      expect(all_cards).to_not include(card2)
      expect(all_cards.count).to eql(1)
    end
  end

end