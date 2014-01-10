class ReviewList < ActiveRecord::Base
  has_many :review_list_tags,
    dependent: :destroy
  has_many :review_list_cards,
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

end
