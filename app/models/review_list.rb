class ReviewList < ActiveRecord::Base
  has_many :review_list_tags,
    dependent: :destroy,
    inverse_of: :review_list
  has_many :review_list_cards,
    dependent: :destroy,
    inverse_of: :review_list,
    dependent: :destroy
  has_many :tags,
    through: :review_list_tags,
    inverse_of: :review_lists
  has_many :cards,
    through: :review_list_cards,
    inverse_of: :review_lists
  belongs_to :user,
    inverse_of: :review_lists

  validates_presence_of :user
  validates_presence_of :amount

  validates_numericality_of :amount,
    only_integer: true,
    greater_than_or_equal_to: 1

  validate :less_than_or_equal_to_available_cards,
    on: :create

  def set_cards(user)
    all_cards = self.all_cards(user)
    if self.srs_review?
      self.set_srs_cards(all_cards)
    else
      self.cards << all_cards.sample(self.amount)
    end
  end

  def set_srs_cards(all_cards)
    not_yet_reviewed = all_cards.select { |card| card.last_studied == nil }
    if !self.new_count.nil? && not_yet_reviewed.count > self.new_count
      self.cards << not_yet_reviewed.sample(self.new_count)
      new_added_count = self.new_count
    else
      self.cards << not_yet_reviewed
      new_added_count = not_yet_reviewed.count
    end
    up_for_review = all_cards.select { |card| card.scheduled_to_recall? && card.last_studied != Date.today }
    if !self.max.nil? && up_for_review.count > ( self.max - new_added_count )
      self.cards << up_for_review.sample( self.max - new_count )
    else
      self.cards << up_for_review
    end
  end

  def all_cards(user)
    all_cards = []
    tags = self.tags
    if tags.size > 0
      tags.each do |tag|
        all_cards << tag.cards
      end
    else
      all_cards = user.cards
    end
    all_cards.flatten
  end

  def review(repeat, recall)
    redirect = false
    if self.srs_review?
      if self.review_list_cards.count > 0 && !recall.nil?
        review_list_card = self.review_list_cards.where(card_id: self.last_card)[0]
        review_list_card.card.process_recall_result(recall.to_i)
        review_list_card.card.save!
        if recall.to_i > 2
          review_list_card.destroy
        end
      end
    else
      if self.review_list_cards.count > 0
        if repeat == 'false' && !repeat.nil?
          review_list_card = self.review_list_cards.where(card_id: self.last_card)
          review_list_card[0].destroy
        end
      end
    end
    card = self.next_card if self.review_list_cards.count != 0
    if self.review_list_cards.count == 0
      self.destroy
      redirect = true
    end
    return card, redirect
  end

  def tags_list
    self.tags.collect {|tag| tag.name }.join(', ')
  end

  def next_card
    review_list_card = self.review_list_cards.shuffle.first
    card = review_list_card.card
    self.last_card = card.id
    self.save!
    card
  end

  def less_than_or_equal_to_available_cards
    if !amount.nil? && amount > self.all_cards(user).count
      errors.add(:amount, "can't be greater than available cards")
    end
  end

end
