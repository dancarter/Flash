class ReviewList < ActiveRecord::Base
  has_many :review_list_tags,
    dependent: :destroy,
    inverse_of: :review_list
  has_many :review_list_cards,
    dependent: :destroy,
    inverse_of: :review_list
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


  def self.set_cards(review_list, user)
    allCards = []
    tags = review_list.tags
    if tags.size > 0
      tags.each do |tag|
        allCards << tag.cards
      end
    else
      allCards = user.cards
    end
    review_list.cards = allCards.flatten.sample(review_list.amount)
  end

  def less_than_or_equal_to_available_cards
    allCards = []
    if tags.size > 0
      tags.each do |tag|
        allCards << tag.cards
      end
    else
      allCards = user.cards
    end
    if amount > allCards.count
      errors.add(:amount, "can't be greater than available cards")
    end
  end

end
