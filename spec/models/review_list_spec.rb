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

  describe '.tags_list' do
    it 'should return a list of all tags on a review list' do
      user = FactoryGirl.create(:user)
      card = FactoryGirl.create(:card, user: user)
      review_list = FactoryGirl.create(:review_list, user: user)
      tag1 = FactoryGirl.create(:tag, user: user)
      tag2 = FactoryGirl.create(:tag, user: user)
      FactoryGirl.create(:tagging, card: card, tag: tag1)
      FactoryGirl.create(:tagging, card: card, tag: tag2)

      review_list.cards << card
      review_list.tags << tag1
      review_list.tags << tag2

      expect(review_list.tags_list).to eql("#{tag1.name}, #{tag2.name}")
    end
  end

  describe '.next_card' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:card) { FactoryGirl.create(:card, user: user) }
    let!(:review_list) { FactoryGirl.create(:review_list, user: user) }

    before :each do
      review_list.cards << card
    end

    it 'should return a card' do
      expect(review_list.next_card).to be_a(Card)
    end

    it "should set last_card to returned card's id" do
      card = review_list.next_card

      expect(review_list.last_card).to eql(card.id)
    end
  end
end
