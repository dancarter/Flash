require 'spec_helper'

describe Copier do
  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}
  let(:card) {FactoryGirl.create(:card_with_tags, user: user1)}

  describe '#copy_tag_to' do
    let(:original) { card.tags.first }
    let(:duplicate) { Copier.copy_tag_to(original, user2) }

    it 'does not associate the original tag to the new user' do
      expect(user2.tags).to_not include(original)
    end

    it 'adds a tag to the user' do
      expect(user2.tags).to include(duplicate)
    end
  end

  describe '#copy_cards_for_tag' do
    let(:destination) { FactoryGirl.create(:tag, user: user2) }
    let(:duplicate_cards) { Copier.copy_cards_for_tag(card.tags.first, destination) }

    it 'does not associate the original card to the new tag' do
      expect(destination.cards).to_not include(card)
    end

    it 'adds new cards to the new tag' do
      duplicate_cards.each do |card|
        expect(destination.cards).to include(card)
      end
    end
  end

end
