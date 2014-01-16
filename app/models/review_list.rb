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
      review_list.cards = ReviewList.all_cards(review_list, user).sample(review_list.amount)
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
