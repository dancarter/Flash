require 'spec_helper'

describe ReviewList do
  it { should validate_presence_of :user }
  it { should validate_presence_of :amount }

  it { should have_many(:review_list_tags).dependent(:destroy) }
  it { should have_many(:review_list_cards).dependent(:destroy) }
  it { should have_many(:cards).through(:review_list_cards) }
  it { should have_many(:tags).through(:review_list_tags) }
  it { should belong_to(:user) }

  describe ".set_cards" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:card) { FactoryGirl.create(:card, user: user) }

    it "should set an amount of random cards for a review list" do
      review_list = FactoryGirl.create(:review_list, user: user)
      FactoryGirl.create(:review_list_card, card: card, review_list: review_list)

      review_list.set_cards(user)
      expect(review_list.cards).to include(card)
    end
  end

  describe ".set_srs_cards" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:card) { FactoryGirl.create(:card, user: user) }
    let!(:srs_review_list) { FactoryGirl.create(:srs_review_list, user: user, max: 1, new_count: 1) }

    it "should pull a new card when new_count is set and a new card exists" do
      srs_review_list.set_srs_cards(user.cards)

      expect(srs_review_list.cards.count).to eql(1)
      expect(srs_review_list.cards).to include(card)
    end

    it "should pull an old card that is scheduled to be reviewed" do
      card.last_studied = Date.today - 1
      card.next_repetition = Date.today
      srs_review_list.set_srs_cards(user.cards)

      expect(srs_review_list.cards.count).to eql(1)
      expect(srs_review_list.cards).to include(card)
    end

    it "should pull no cards if nothing is scheduled and no new cards" do
      srs_review_list.set_srs_cards(user.cards)
      srs_review_list.review(nil, nil)
      srs_review_list.review(nil, 5)

      srs_review_list_2 = FactoryGirl.create(:srs_review_list, user: user, max: 1, new_count: 0)
      srs_review_list_2.set_srs_cards(user.cards)

      expect(srs_review_list_2.cards.count).to eql(0)
      expect(srs_review_list_2.cards).to_not include(card)
    end
  end

  describe ".all_cards" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:card) { FactoryGirl.create(:card, user: user) }
    let!(:review_list) { FactoryGirl.create(:review_list, user: user) }

    it "should return all cards available to a review list" do
      all_cards = review_list.all_cards(user)
      expect(all_cards).to include(card)
    end

    it "should return only cards available to tags specified" do
      tag = FactoryGirl.create(:tag, user: user)
      card2 = FactoryGirl.create(:card, user: user)
      FactoryGirl.create(:tagging, card: card, tag: tag)
      review_list.tags << tag

      all_cards = review_list.all_cards(user)
      expect(all_cards).to include(card)
      expect(all_cards).to_not include(card2)
      expect(all_cards.count).to eql(1)
    end
  end

  describe '.review' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:card1) { FactoryGirl.create(:card, user: user) }
    let!(:review_list) { FactoryGirl.create(:review_list, user: user) }
    let!(:srs_review_list) { FactoryGirl.create(:srs_review_list, user: user) }

    it "should return a card and false if at least one card remains for non-SRS" do
      card2 = FactoryGirl.create(:card, user: user)
      review_list.set_cards(user)
      card, redirect = review_list.review(nil, nil)

      expect(card).to be_a(Card)
      expect(redirect).to eql(false)
    end

    it "should return a card and true if no more cards remain for non-SRS" do
      review_list.set_cards(user)
      card, redirect = review_list.review(nil, nil)

      expect(card).to be_a(Card)
      expect(redirect).to eql(false)
    end

    it "should leave the card in the list if repeat is true" do
      review_list.set_cards(user)
      review_list.review(nil, nil)
      review_list.review(nil, true)

      expect(review_list.cards).to include(card1)
    end

    it "should return a card and false if at least one card remains for SRS" do
      srs_review_list = FactoryGirl.create(:srs_review_list, user: user, max: 2, new_count: 2)
      card2 = FactoryGirl.create(:card, user: user)
      srs_review_list.set_cards(user)
      card, redirect = srs_review_list.review(nil, nil)

      expect(card).to be_a(Card)
      expect(redirect).to eql(false)
    end

    it "should return a card and true if no more cards remain for SRS" do
      srs_review_list = FactoryGirl.create(:srs_review_list, user: user, max: 2, new_count: 2)
      srs_review_list.set_cards(user)
      card, redirect = srs_review_list.review(nil, nil)

      expect(card).to be_a(Card)
      expect(redirect).to eql(false)
    end

    it "should leave the card in the list if recall isn't over 2" do
      srs_review_list = FactoryGirl.create(:srs_review_list, user: user, max: 1, new_count: 1)
      srs_review_list.set_cards(user)
      srs_review_list.review(nil, nil)
      srs_review_list.review(2, nil)

      expect(srs_review_list.cards).to include(card1)
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
