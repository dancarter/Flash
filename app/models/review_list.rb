class ReviewList < ActiveRecord::Base
  has_many :review_list_tags,
    inverse_of: :review_list,
    dependent: :destroy
  has_many :review_list_cards,
    inverse_of: :review_list,
    dependent: :destroy
  has_many :tags,
    through: :review_list_tags,
    inverse_of: :review_list
  has_many :cards,
    through: :review_list_cards,
    inverse_of: :review_list

  # def initialize(amount, tags=[])
  #   @tags = tags
  #   @amount = amount
  # end

  # def setCards
  #   allCards = []
  #   if @tags.size > 0
  #     @tags.each do |tag|
  #       allCards << tag.cards
  #     end
  #   else
  #     allCards = current_user.cards
  #   end
  #   binding.pry
  #   @cards = allCards.flatten.sample(@amount)
  # end

end
