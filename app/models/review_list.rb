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

  class << self
    def set_cards(review_list, user)
      all_cards = ReviewList.all_cards(review_list, user)
      if review_list.srs_review?
        set_srs_cards(review_list, all_cards)
      else
        review_list.cards << all_cards.sample(review_list.amount)
      end
    end

    def set_srs_cards(review_list, all_cards)
      not_yet_reviewed = all_cards.select { |card| card.last_studied == nil }
      if not_yet_reviewed.count > review_list.new_count
        review_list.cards << not_yet_reviewed.sample(review_list.new_count)
        new_count = review_list.new_count
      else
        review_list.cards << not_yet_reviewed
        new_count = not_yet_reviewed.count
      end
      up_for_review = all_cards.select { |card| card.scheduled_to_recall? && card.last_studied != Date.today }
      if up_for_review.count > ( review_list.amount - new_count )
        review_list.cards << up_for_review.sample( review_list.amount - new_count )
      else
        review_list.cards << up_for_review
      end
    end

    def all_cards(review_list, user)
      all_cards = []
      tags = review_list.tags
      if tags.size > 0
        tags.each do |tag|
          all_cards << tag.cards
        end
      else
        all_cards = user.cards
      end
      all_cards.flatten
    end
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
    if !amount.nil? && amount > ReviewList.all_cards(self, user).count
      errors.add(:amount, "can't be greater than available cards")
    end
  end

end
